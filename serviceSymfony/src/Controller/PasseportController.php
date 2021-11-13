<?php

namespace App\Controller;

use App\Entity\Passeport;
use App\Form\PasseportType;
use App\Repository\PasseportRepository;
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
    public function addPasseportJSON(Request $request, NormalizerInterface $Normalizer,FileUploader $fileUploader): Response
    {
        $passeport = new Passeport();
        $timeDate = new \DateTime ();
        $timeString= $timeDate->format('d/m/Y');
        $passeport->setIdUser($request->get('idUser'));
        $passeport->setEtat("En attente");
        $passeport->setDate($timeDate);
        $filePath=$request->get('urlImage');
        $fileName=basename($filePath);
        $uploadedFile= new UploadedFile($filePath,$fileName, null, null, true);
        $imageFileName=$fileUploader->upload($uploadedFile);
        $passeport->setUrlImage($imageFileName);



        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->persist($passeport);
        $entityManager->flush();

        $jsonContent=$Normalizer->normalize($passeport,'json',['groups'=>'post:read']);
        return new Response("Passeport added successfully".json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
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
