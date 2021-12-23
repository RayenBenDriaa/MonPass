<?php

namespace App\Controller;

use App\Entity\Passeport;
use App\Entity\User;
use App\Form\PasseportType;
use App\Repository\PasseportRepository;
use App\Repository\UserRepository;
use App\Service\FileUploader;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;
use Symfony\Component\Finder\Finder;

/**
 * @Route("/passeport")
 */
class PasseportController extends AbstractController
{
    /**
     * @Route("/", name="passeport_index", methods={"GET"})
     */
    public function index(PasseportRepository $passeportRepository): Response
    {
        return $this->render('passeport/index.html.twig', [
            'passeports' => $passeportRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="passeport_new", methods={"GET","POST"})
     */
    public function new(Request $request): Response
    {
        $passeport = new Passeport();
        $form = $this->createForm(PasseportType::class, $passeport);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($passeport);
            $entityManager->flush();

            return $this->redirectToRoute('passeport_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('passeport/new.html.twig', [
            'passeport' => $passeport,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/addPasseportJSON", name="passeportJSON_new")
     */
    public function addPasseportJSON(Request $request,PasseportRepository $repository, UserRepository $userRepository): Response
    {
        $passeport = $repository->findOneBy(['idUser' => $request->get('idUser')]);
        if($passeport!=null)
        {
            return new Response("\n -Vous avez déjà déposer ce document(Passeport), veuillez attendre la validation par un administrateur.");
        }
        else
        {
            $passeport = new Passeport();
            $timeDate = new \DateTime ();
            $passeport->setIdUser($_POST['idUser']);
            $passeport->setEtat("En attente");
            $passeport->setDate($timeDate);
            $imageName= $passeport->getIdUser()."PASSEPORT".$_POST['imageName'];
            $image= base64_decode($_POST['image64']);
            file_put_contents("C:\Users\xmr0j\Documents\Flutter Projects\monpassflutterproject\assets\uploadedImages\\".$imageName,$image);
            $passeport->setUrlImage($imageName);
            $passeport->setUser($userRepository->findOneBy(['id'=>$_POST['idUser']]));
            $user=$userRepository->findOneBy(['id'=>$_POST['idUser']]);
            $passeport->setUser($user);
            //$user->setPasseport($passeport);



            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($passeport);
            $entityManager->persist($user);
            $entityManager->flush();


            return new Response("\n -Passeport ajouté avec succés");
        }

    }
      /**
     * @Route("/countPassportJson",name="countPassport")
     */
    public function countPassoportJSON(Request $request,PasseportRepository $repository,NormalizerInterface $Normalizer): Response
    {
          $count = $repository->getNbrePassport();
          $jsonContent=$Normalizer->normalize($count,'json',['groups'=>'post:read']);
          return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));

    }

    /**
     * @Route("/showPasseportJSON/{id}", name="passeportJSON_show")
     */
    public function showPasseportJSON(int $id,Request $request, NormalizerInterface $Normalizer,PasseportRepository $repository): Response
    {
        $passeport = $repository->findOneBy(['idUser' => $id]);
        $jsonContent=$Normalizer->normalize($passeport,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }

    /**
     * @Route("/getAllPasseportJSON", name="getAllPasseportJSON_index")
     */
    public function getAllPasseportJSON(PasseportRepository $passeportRepository, NormalizerInterface $Normalizer, UserRepository $userRepository): Response
    {
        $passeports=$passeportRepository->findBy(['etat'=>"En attente"]);
        foreach ($passeports as $passeport){
            if ($passeport->getUser()==null)
            {
                $passeport->setUser($userRepository->findOneBy(['id'=>$passeport->getIdUser()]));
            }
        }
        $jsonContent=$Normalizer->normalize($passeports,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }
    /**
     * @Route("/editPasseportJSON/{id}", name="passeportJSON_edit")
     */
    public function editPasseportJSON(int $id,Request $request, UserRepository $userRepository, PasseportRepository $repository): Response
    {
        $passeport = $repository->findOneBy(['idUser' => $id]);
        $user=$userRepository->findOneBy(['id'=>$passeport->getIdUser()]);
        $user->setPasseport($passeport);
        $passeport->setEtat("Validé");
        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->flush();
        return new Response("Passeport modifié avec succés");
    }

    /**
     * @Route("/deletePasseportJSON/{id}", name="passeportJSON_delete")
     */
    public function deletePasseportJSON(int $id,Request $request, PasseportRepository $repository,UserRepository $userRepository): Response
    {
        $passeport = $repository->findOneBy(['idUser' => $id]);
        $user=$userRepository->findOneBy(['id'=>$passeport->getIdUser()]);
        $user->setPasseport($passeport);
        $passeport->setEtat("Refusé");
        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->flush();
        return new Response("Passeport supprimé avec succés");
    }

    /**
     * @Route("/{id}", name="passeport_show", methods={"GET"})
     */
    public function show(Passeport $passeport): Response
    {
        return $this->render('passeport/show.html.twig', [
            'passeport' => $passeport,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="passeport_edit", methods={"GET","POST"})
     */
    public function edit(Request $request, Passeport $passeport): Response
    {
        $form = $this->createForm(PasseportType::class, $passeport);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('passeport_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('passeport/edit.html.twig', [
            'passeport' => $passeport,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="passeport_delete", methods={"POST"})
     */
    public function delete(Request $request, Passeport $passeport): Response
    {
        if ($this->isCsrfTokenValid('delete'.$passeport->getId(), $request->request->get('_token'))) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->remove($passeport);
            $entityManager->flush();
        }

        return $this->redirectToRoute('passeport_index', [], Response::HTTP_SEE_OTHER);
    }
     
}
