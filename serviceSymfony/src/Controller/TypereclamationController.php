<?php

namespace App\Controller;

use App\Entity\Typereclamation;
use App\Form\TypereclamationType;
use App\Repository\TypereclamationRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

/**
 * @Route("/typereclamation")
 */
class TypereclamationController extends AbstractController
{
    /**
     * @Route("/getTypeJSON", name="getTypeJSON")
     */
    public function getTypeJSON(NormalizerInterface $Normalizer): Response
    {
        $types = $this->getDoctrine()
            ->getRepository(Typereclamation::class)
            ->findAll();
        $jsonContent=$Normalizer->normalize($types,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }

    /**
     * @Route("/", name="typereclamation_index", methods={"GET"})
     */
    public function index(TypereclamationRepository $typereclamationRepository): Response
    {
        return $this->render('typereclamation/index.html.twig', [
            'typereclamations' => $typereclamationRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="typereclamation_new", methods={"GET", "POST"})
     */
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $typereclamation = new Typereclamation();
        $form = $this->createForm(TypereclamationType::class, $typereclamation);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($typereclamation);
            $entityManager->flush();

            return $this->redirectToRoute('typereclamation_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('typereclamation/new.html.twig', [
            'typereclamation' => $typereclamation,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="typereclamation_show", methods={"GET"})
     */
    public function show(Typereclamation $typereclamation): Response
    {
        return $this->render('typereclamation/show.html.twig', [
            'typereclamation' => $typereclamation,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="typereclamation_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Typereclamation $typereclamation, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(TypereclamationType::class, $typereclamation);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            return $this->redirectToRoute('typereclamation_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('typereclamation/edit.html.twig', [
            'typereclamation' => $typereclamation,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="typereclamation_delete", methods={"POST"})
     */
    public function delete(Request $request, Typereclamation $typereclamation, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$typereclamation->getId(), $request->request->get('_token'))) {
            $entityManager->remove($typereclamation);
            $entityManager->flush();
        }

        return $this->redirectToRoute('typereclamation_index', [], Response::HTTP_SEE_OTHER);
    }
}
