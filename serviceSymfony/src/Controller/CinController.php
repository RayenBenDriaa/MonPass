<?php

namespace App\Controller;

use App\Entity\Cin;
use App\Form\CinType;
use App\Repository\CinRepository;
use App\Service\FileUploader;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

/**
 * @Route("/cin")
 */
class CinController extends AbstractController
{
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
     * @Route("/addCinJSON", name="cinJSON_new")
     */
    public function addCinJSON(Request $request, NormalizerInterface $Normalizer,FileUploader $fileUploader, CinRepository $repository): Response
    {
        $cin = $repository->findOneBy(['idUser' => $request->get('idUser')]);
        if($cin!=null)
        {
            return new Response("Vous avez déjà déposer ce document, veuillez attendre la validation par un administrateur.");
        }
        else
        {
            $cin = new Cin();
            $timeDate = new \DateTime ();
            $timeString= $timeDate->format('d/m/Y');
            $cin->setIdUser($request->get('idUser'));
            $cin->setEtat("En attente");
            $cin->setDate($timeDate);
            $filePath=$request->get('urlImage');
            $fileName=basename($filePath);
            $uploadedFile= new UploadedFile($filePath,$fileName, null, null, true);
            $imageFileName=$fileUploader->upload($uploadedFile);
            $cin->setUrlImage($imageFileName);



            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($cin);
            $entityManager->flush();

            $jsonContent=$Normalizer->normalize($cin,'json',['groups'=>'post:read']);
            return new Response("Carte d'identité nationale ajouter avec succés");
        }

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
