<?php

namespace App\Controller;

use App\Entity\Cin;
use App\Entity\User;
use App\Form\CinType;
use App\Repository\CinRepository;
use App\Repository\UserRepository;
use App\Service\FileUploader;
use PhpParser\Node\Scalar\MagicConst\File;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;
use Hshn\Base64EncodedFile\HttpFoundation\File\Base64EncodedFile;
use Psr\Log\LoggerInterface;

/**
 * @Route("/cin")
 */
class CinController extends AbstractController
{

    /**
     * @Route("/addCinJSON", name="cinJSON_new")
     */
    public function addCinJSON(Request $request, CinRepository $repository, UserRepository $userRepository): Response
    {
        $cin = $repository->findOneBy(['idUser' => $request->get('idUser')]);
        if($cin!=null)
        {
            return new Response("\n -Vous avez déjà déposer ce document(CIN), veuillez attendre la validation par un administrateur.");
        }
        else
        {

            $cin = new Cin();
            $timeDate = new \DateTime ();
            $cin->setIdUser($_POST['idUser']);
            $cin->setEtat("En attente");
            $cin->setDate($timeDate);
            $imageName= $cin->getIdUser()."CIN".$_POST['imageName'];
            $image= base64_decode($_POST['image64']);
            file_put_contents("..\public\uploadedImages\\".$imageName,$image);
            $cin->setUrlImage($imageName);
            $cin->setUser($userRepository->findOneBy(['id'=>$_POST['idUser']]));
            $user=$userRepository->findOneBy(['id'=>$_POST['idUser']]);
            $cin->setUser($user);
            //$user->setCin($cin);



            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($cin);
            //$entityManager->persist($user);
            $entityManager->flush();

            //$jsonContent=$Normalizer->normalize($cin,'json',['groups'=>'post:read']);
            return new Response("\n -Carte d'identité nationale ajoutée avec succés");
        }

    }

    /**
     * @Route("/showCinJSON/{id}", name="cinJSON_show")
     */
    public function showCinJSON(int $id,Request $request, NormalizerInterface $Normalizer, CinRepository $repository): Response
    {
        $cin = $repository->findOneBy(['idUser' => $id]);
        $jsonContent=$Normalizer->normalize($cin,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }

    /**
     * @Route("/getAllCinJSON", name="getAllCinJSON_index")
     */
    public function getAllCinJSON(CinRepository $cinRepository, NormalizerInterface $Normalizer, UserRepository $userRepository): Response
    {
        $cins=$cinRepository->findBy(['etat'=>"En attente"]);
        foreach ($cins as $cin){
            if ($cin->getUser()==null)
            {
                $cin->setUser($userRepository->findOneBy(['id'=>$cin->getIdUser()]));
            }
        }
        $jsonContent=$Normalizer->normalize($cins,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }
    /**
     * @Route("/editCinJSON/{id}", name="cinJSON_edit")
     */
    public function editCinJSON(int $id,Request $request, UserRepository $userRepository, CinRepository $repository): Response
    {
        $cin = $repository->findOneBy(['idUser' => $id]);
        $user=$userRepository->findOneBy(['id'=>$cin->getIdUser()]);
        $user->setCin($cin);
        $cin->setEtat("Validé");
        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->flush();
        return new Response("Cin modifié avec succés");
    }
    /**
     * @Route("/countCinJson",name="countCin")
     */
    public function countCinJSON(Request $request,CinRepository $repository,NormalizerInterface $Normalizer): Response
    {
          $count = $repository->getNbreCin();
          $jsonContent=$Normalizer->normalize($count,'json',['groups'=>'post:read']);
          return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));

    }
  

    /**
     * @Route("/deleteCinJSON/{id}", name="cinJSON_delete")
     */
    public function deleteCinJSON(int $id,Request $request, CinRepository $repository, UserRepository $userRepository): Response
    {
        $cin = $repository->findOneBy(['idUser' => $id]);
        $user=$userRepository->findOneBy(['id'=>$cin->getIdUser()]);
        $user->setCin($cin);
        $cin->setEtat("Refusé");
        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->flush();
        return new Response("Cin supprimé avec succés");
    }

   

    /**
     * @Route("/", name="cin_index", methods={"GET"})
     */
    public function index(CinRepository $cinRepository): Response
    {
        return $this->render('cin/index.html.twig', [
            'cins' => $cinRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="cin_new", methods={"GET","POST"})
     */
    public function new(Request $request): Response
    {
        $cin = new Cin();
        $form = $this->createForm(CinType::class, $cin);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($cin);
            $entityManager->flush();

            return $this->redirectToRoute('cin_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('cin/new.html.twig', [
            'cin' => $cin,
            'form' => $form->createView(),
        ]);
    }





    /**
     * @Route("/{id}", name="cin_show", methods={"GET"})
     */
    public function show(Cin $cin): Response
    {
        return $this->render('cin/show.html.twig', [
            'cin' => $cin,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="cin_edit", methods={"GET","POST"})
     */
    public function edit(Request $request, Cin $cin): Response
    {
        $form = $this->createForm(CinType::class, $cin);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('cin_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('cin/edit.html.twig', [
            'cin' => $cin,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="cin_delete", methods={"POST"})
     */
    public function delete(Request $request, Cin $cin): Response
    {
        if ($this->isCsrfTokenValid('delete'.$cin->getId(), $request->request->get('_token'))) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->remove($cin);
            $entityManager->flush();
        }

        return $this->redirectToRoute('cin_index', [], Response::HTTP_SEE_OTHER);
    }
}
