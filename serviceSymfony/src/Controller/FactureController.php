<?php

namespace App\Controller;

use App\Entity\Facture;
use App\Form\FactureType;
use App\Repository\FactureRepository;
use App\Service\FileUploader;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

/**
 * @Route("/facture")
 */
class FactureController extends AbstractController
{
    /**
     * @Route("/", name="facture_index", methods={"GET"})
     */
    public function index(FactureRepository $factureRepository): Response
    {
        return $this->render('facture/index.html.twig', [
            'factures' => $factureRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="facture_new", methods={"GET","POST"})
     */
    public function new(Request $request): Response
    {
        $facture = new Facture();
        $form = $this->createForm(FactureType::class, $facture);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($facture);
            $entityManager->flush();

            return $this->redirectToRoute('facture_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('facture/new.html.twig', [
            'facture' => $facture,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/addFactureJSON", name="factureJSON_new")
     */
    public function addFactureJSON(Request $request,FactureRepository $repository): Response
    {
        $facture = $repository->findOneBy(['idUser' => $request->get('idUser')]);
        if($facture!=null)
        {
            return new Response("Vous avez déjà déposer ce document(Facture), veuillez attendre la validation par un administrateur.");
        }
        else
        {
            $facture = new Facture();
            $timeDate = new \DateTime ();
            $facture->setIdUser($_POST['idUser']);
            $facture->setEtat("En attente");
            $facture->setDate($timeDate);
            $imageName= $facture->getIdUser()."FACTURE".$_POST['imageName'];
            $image= base64_decode($_POST['image64']);
            file_put_contents("C:\Users\xmr0j\Documents\Flutter Projects\monpassflutterproject\assets\uploadedImages\\".$imageName,$image);
            $facture->setUrlImage($imageName);



            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($facture);
            $entityManager->flush();

            return new Response("Facture ajouter avec succés");
        }

    }

    /**
     * @Route("/showFactureJSON", name="factureJSON_show")
     */
    public function showFactureJSON(Request $request, NormalizerInterface $Normalizer, FactureRepository $repository): Response
    {
        $facture = $repository->findOneBy(['idUser' => $request->get('idUser')]);
        $entityManager = $this->getDoctrine()->getManager();
        $jsonContent=$Normalizer->normalize($facture,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }

    /**
     * @Route("/{id}", name="facture_show", methods={"GET"})
     */
    public function show(Facture $facture): Response
    {
        return $this->render('facture/show.html.twig', [
            'facture' => $facture,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="facture_edit", methods={"GET","POST"})
     */
    public function edit(Request $request, Facture $facture): Response
    {
        $form = $this->createForm(FactureType::class, $facture);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('facture_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('facture/edit.html.twig', [
            'facture' => $facture,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="facture_delete", methods={"POST"})
     */
    public function delete(Request $request, Facture $facture): Response
    {
        if ($this->isCsrfTokenValid('delete'.$facture->getId(), $request->request->get('_token'))) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->remove($facture);
            $entityManager->flush();
        }

        return $this->redirectToRoute('facture_index', [], Response::HTTP_SEE_OTHER);
    }
}
