<?php

namespace App\Controller;

use App\Entity\Cin;
use App\Form\CinType;
use App\Repository\CinRepository;
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
    public function addCinJSON(Request $request, CinRepository $repository): Response
    {
        $cin = $repository->findOneBy(['idUser' => $request->get('idUser')]);
        if($cin!=null)
        {
            return new Response("Vous avez déjà déposer ce document(CIN), veuillez attendre la validation par un administrateur.");
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
            file_put_contents("C:\Users\xmr0j\Documents\Flutter Projects\monpassflutterproject\assets\uploadedImages\\".$imageName,$image);
            $cin->setUrlImage($imageName);



            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($cin);
            $entityManager->flush();

            //$jsonContent=$Normalizer->normalize($cin,'json',['groups'=>'post:read']);
            return new Response("Carte d'identité nationale ajouter avec succés");
        }

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
     * @Route("/showCinJSON", name="cinJSON_show")
     */
    public function showCinJSON(Request $request, NormalizerInterface $Normalizer, CinRepository $repository): Response
    {
        $cin = $repository->findOneBy(['idUser' => $request->get('idUser')]);
        $entityManager = $this->getDoctrine()->getManager();
        $jsonContent=$Normalizer->normalize($cin,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
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
