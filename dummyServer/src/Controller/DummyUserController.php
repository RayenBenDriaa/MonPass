<?php

namespace App\Controller;

use App\Entity\DummyUser;
use App\Form\DummyUserType;
use App\Repository\DummyUserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/dummy/user")
 */
class DummyUserController extends AbstractController
{
    /**
     * @Route("/", name="dummy_user_index", methods={"GET"})
     */
    public function index(DummyUserRepository $dummyUserRepository): Response
    {
        return $this->render('dummy_user/index.html.twig', [
            'dummy_users' => $dummyUserRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="dummy_user_new", methods={"GET", "POST"})
     */
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $dummyUser = new DummyUser();
        $form = $this->createForm(DummyUserType::class, $dummyUser);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($dummyUser);
            $entityManager->flush();

            return $this->redirectToRoute('dummy_user_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('dummy_user/new.html.twig', [
            'dummy_user' => $dummyUser,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="dummy_user_show", methods={"GET"})
     */
    public function show(DummyUser $dummyUser): Response
    {
        return $this->render('dummy_user/show.html.twig', [
            'dummy_user' => $dummyUser,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="dummy_user_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, DummyUser $dummyUser, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(DummyUserType::class, $dummyUser);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            return $this->redirectToRoute('dummy_user_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('dummy_user/edit.html.twig', [
            'dummy_user' => $dummyUser,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="dummy_user_delete", methods={"POST"})
     */
    public function delete(Request $request, DummyUser $dummyUser, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$dummyUser->getId(), $request->request->get('_token'))) {
            $entityManager->remove($dummyUser);
            $entityManager->flush();
        }

        return $this->redirectToRoute('dummy_user_index', [], Response::HTTP_SEE_OTHER);
    }
}
