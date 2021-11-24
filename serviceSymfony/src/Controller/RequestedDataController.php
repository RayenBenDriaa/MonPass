<?php

namespace App\Controller;

use App\Entity\RequestedData;
use App\Form\RequestedDataType;
use App\Repository\RequestedDataRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

/**
 * @Route("/requested/data")
 */
class RequestedDataController extends AbstractController
{
    /**
     * @Route("/", name="requested_data_index", methods={"GET"})
     */
    public function index(RequestedDataRepository $requestedDataRepository): Response
    {
        return $this->render('requested_data/index.html.twig', [
            'requested_datas' => $requestedDataRepository->findAll(),
        ]);
    }

    /**
     * @Route("/addRdJSON", name="rdJSON_new")
     */
    public function addRdJSON(Request $request, RequestedDataRepository $repository): Response
    {
        $rd = $repository->findOneBy(['fromWho' => $request->get('fromWho')
            ,'ofWho' => $request->get('ofWho')
            ,'approval'=>'no']);
        if($rd!=null)
        {
            return new Response("\n Une requéte de donnée a déjà été faite, veuillez patienter.");
        }
        else
        {

            $rd = new RequestedData();
            $timeDate = new \DateTime ();
            $rd->setFromWho($request->get('fromWho'));
            $rd->setApproval("no");
            $rd->setDate($timeDate);
            $rd->setOfWho($request->get('ofWho'));
            $rd->setCin($request->get('cin'));
            $rd->setPasseport($request->get('passeport'));
            $rd->setFacture($request->get('facture'));

            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($rd);
            $entityManager->flush();

            //$jsonContent=$Normalizer->normalize($cin,'json',['groups'=>'post:read']);
            return new Response("\n -Requete de donnée envoyé avec succés");
        }

    }

    /**
     * @Route("/showRdJSON/{email}", name="rdJSON_show")
     */
    public function showRdJSON(String $email,Request $request, NormalizerInterface $Normalizer, RequestedDataRepository $repository): Response
    {
        $rd = $repository->findOneBy(['ofWho' => $email]);
        $jsonContent=$Normalizer->normalize($rd,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }

    /**
     * @Route("/editRdJSON/{id}", name="rdJSON_edit")
     */
    public function editRdJSON(int $id,Request $request, RequestedDataRepository $repository, EntityManagerInterface $entityManager): Response
    {
        $rd = $repository->findOneBy(['id' => $id]);
        $rd->setApproval("yes");
        $entityManager->flush();
        return new Response("\n -Edit request data avec succés");
    }

    /**
     * @Route("/new", name="requested_data_new", methods={"GET", "POST"})
     */
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $requestedDatum = new RequestedData();
        $form = $this->createForm(RequestedDataType::class, $requestedDatum);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($requestedDatum);
            $entityManager->flush();

            return $this->redirectToRoute('requested_data_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('requested_data/new.html.twig', [
            'requested_datum' => $requestedDatum,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="requested_data_show", methods={"GET"})
     */
    public function show(RequestedData $requestedDatum): Response
    {
        return $this->render('requested_data/show.html.twig', [
            'requested_datum' => $requestedDatum,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="requested_data_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, RequestedData $requestedDatum, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(RequestedDataType::class, $requestedDatum);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            return $this->redirectToRoute('requested_data_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('requested_data/edit.html.twig', [
            'requested_datum' => $requestedDatum,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="requested_data_delete", methods={"POST"})
     */
    public function delete(Request $request, RequestedData $requestedDatum, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$requestedDatum->getId(), $request->request->get('_token'))) {
            $entityManager->remove($requestedDatum);
            $entityManager->flush();
        }

        return $this->redirectToRoute('requested_data_index', [], Response::HTTP_SEE_OTHER);
    }
}
