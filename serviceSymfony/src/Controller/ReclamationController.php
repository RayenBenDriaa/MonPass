<?php

namespace App\Controller;

use App\Entity\Reclamation;
use App\Entity\Typereclamation;
use App\Entity\User;
use App\Form\ReclamationType;
use App\Repository\ReclamationRepository;
use App\Repository\TypereclamationRepository;
use App\Repository\UserRepository;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;

/**
 * @Route("/reclamation")
 */
class ReclamationController extends AbstractController
{

    /**
     * @Route("/getReclamationsJSON", name="getReclamationsJSON")
     */
    public function getReclamationsJSON(NormalizerInterface $Normalizer): Response
    {
        $reclamations = $this->getDoctrine()
            ->getRepository(Reclamation::class)
            ->findAll();

        $jsonContent=$Normalizer->normalize($reclamations,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }

    /**
     * @Route("/getReclamationsJSONBy/{id}", name="getReclamationsJSONById")
     */
    public function getReclamationsJSONById(int $id,UserRepository $userRepository,NormalizerInterface $Normalizer): Response
    {
        $user=$userRepository->findOneBy(['id'=>$id]);
        $reclamations = $this->getDoctrine()
            ->getRepository(Reclamation::class)
            ->findBy(['user'=>$user]);

        $jsonContent=$Normalizer->normalize($reclamations,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }

    /**
     * @Route("/deleteReclamationsJSON/{id}", name="deleteReclamationsJSON")
     */
    public function deleteReclamationsJSON(Request $request,NormalizerInterface $Normalizer,$id): Response
    {
        $em=$this->getDoctrine()->getManager();
        $reclamation=$em->getRepository(Reclamation::class)->find($id);
        $em->remove($reclamation);
        $em->flush();
        $jsonContent=$Normalizer->normalize($reclamation,'json',['groups'=>'post:read']);
        return new Response("Reclamation deleted successfully".json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
    }

    /**
     * @Route("/addReclamationsJSON", name="addReclamationsJSON")
     */
    public function addReclamationsJSON(Request $request,NormalizerInterface $Normalizer,UserRepository $userRepository,TypereclamationRepository $typereclamationRepository): Response
    {

        $reclamation=new Reclamation();
        $timeDate = new DateTime ();

        $reclamation->setUser($userRepository->findOneBy(['id'=>$request->get('idUser')]));
        $reclamation->setDescriptionreclamation($request->get('description'));
        $reclamation->setDatereclamation($timeDate);
        $reclamation->setEncours(0);
        $reclamation->setTraite(0);
        $reclamation->setTypeReclamation($typereclamationRepository->findOneBy(['typereclamation'=>$request->get('typeReclamation')]));


        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->persist($reclamation);
        $entityManager->flush();


        return new Response("Reclamation added successfully");
    }

    /**
     * @Route("/editReclamationJSON/{id}", name="editReclamationJSON")
     */

    public function editReclamationJSON(Request $request,ReclamationRepository $repository,MailerInterface $mailer,NormalizerInterface $Normalizer,int $id): Response
    {

        $entityManager=$this->getDoctrine()->getManager();
        $reclamation =$repository->findOneBy(['id'=>$id]);
        $userMail=$reclamation->getUser()->getEmail();



        if ($reclamation->getEncours()==0 && $reclamation->getTraite()==0 ) {
            $reclamation->setEncours(1);
            $entityManager->flush();
        }
        elseif ($reclamation->getEncours()==1 && $reclamation->getTraite()==0 ) {
            $reclamation->setEncours(0);
            $reclamation->setTraite(1);
            $entityManager->flush();
            $message = (new Email())
                ->from('monpasse.tunisie@gmail.com')
                ->to($userMail)
                ->subject('Mon Passe : Reclamation traité')
                ->text(
                    "Salut M/Mme. ".$reclamation->getUser()->getNom()." \nl'équipe de Mon passe vous informe que l'une de vos réclamation "
                    . "qui était en cours de traitement vient d'être terminé.\nCordialement, Mon Passe"
                )
            ;

            $mailer->send($message);
        }

        $jsonContent=$Normalizer->normalize($reclamation,'json',['groups'=>'post:read']);
        return new Response("Reclamation edited successfully".json_encode($jsonContent,JSON_UNESCAPED_UNICODE));

    }

    /**
     * @Route("/", name="reclamation_index", methods={"GET"})
     */
    public function index(ReclamationRepository $reclamationRepository): Response
    {
        return $this->render('reclamation/index.html.twig', [
            'reclamations' => $reclamationRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="reclamation_new", methods={"GET", "POST"})
     */
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $reclamation = new Reclamation();
        $form = $this->createForm(ReclamationType::class, $reclamation);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($reclamation);
            $entityManager->flush();

            return $this->redirectToRoute('reclamation_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('reclamation/new.html.twig', [
            'reclamation' => $reclamation,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="reclamation_show", methods={"GET"})
     */
    public function show(Reclamation $reclamation): Response
    {
        return $this->render('reclamation/show.html.twig', [
            'reclamation' => $reclamation,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="reclamation_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Reclamation $reclamation, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(ReclamationType::class, $reclamation);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            return $this->redirectToRoute('reclamation_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('reclamation/edit.html.twig', [
            'reclamation' => $reclamation,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="reclamation_delete", methods={"POST"})
     */
    public function delete(Request $request, Reclamation $reclamation, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$reclamation->getId(), $request->request->get('_token'))) {
            $entityManager->remove($reclamation);
            $entityManager->flush();
        }

        return $this->redirectToRoute('reclamation_index', [], Response::HTTP_SEE_OTHER);
    }
}
