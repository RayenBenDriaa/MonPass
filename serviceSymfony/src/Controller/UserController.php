<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\UserType;
use App\Repository\UserRepository;
use App\Service\FileUploader;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;
use Symfony\Component\Finder\Finder;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Csrf\TokenGenerator\TokenGeneratorInterface;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;


/**
 * @Route("/api")
 */
class UserController extends AbstractController
{

    /**
     * @Route("/getDocsBy/{id}", name="getDocsBy_id")
     */
    public function getDocsById(int $id,Request $request, NormalizerInterface $Normalizer,UserRepository $repository): Response
    {
        $imageFolder='C:\Users\xmr0j\Documents\Flutter Projects\monpassflutterproject\assets\uploadedImages\\';
        $user = $repository->findOneBy(['id' => $id]);
        if($user==null){
            return new Response("User not found");
        }
        else
        {
            $imageCin="null";
            if($user->getCin()!=null)
            {
                if($user->getCin()->getUrlImage()!=null){
                    $imageCin=$imageFolder.$user->getCin()->getUrlImage();
                }
            }

            $imagePasseport="null";
            if($user->getPasseport()!=null)
            {
                if($user->getPasseport()->getUrlImage()!=null){
                    $imagePasseport=$imageFolder.$user->getPasseport()->getUrlImage();
                }
            }

            $imageFacture="null";
            if($user->getFacture()!=null)
            {
                if($user->getFacture()->getUrlImage()!=null){
                    $imageFacture=$imageFolder.$user->getFacture()->getUrlImage();
                }
            }

            $tabInfo= array('imageCin'=>$imageCin,
                'imagePasseport'=>$imagePasseport,
                'imageFacture'=>$imageFacture);

            $jsonContent=$Normalizer->normalize($tabInfo,'json',['groups'=>'post:read']);
            return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));
        }
    }

     /**
     * @Route("/addUserJSON", name="userJSON_new")
     */
    public function addUserJSON(Request $request, NormalizerInterface $Normalizer,UserRepository $repository,UserPasswordEncoderInterface $encoder): Response
    {
        
            $user = new User();
            
           
            
            $user->setNom($request->get('nom'));
            $user->setPrenom($request->get('prenom'));
            $user->setEmail($request->get('email'));
           // $hash=$encoder->encodePassword($user,$request->get('password'));
            $user->setPassword($request->get('password'));
            $user->setNumtel($request->get('numtel'));
            



            $entityManager = $this->getDoctrine()->flush();
            $entityManager->persist($user);
            $entityManager->flush();
           

         $jsonContent=$Normalizer->normalize($user,'json',['groups'=>'post:read']);
            return new Response("user ajouter avec succés");
     }
        /**
     * @Route("/EditUserJSON/{email}", name="editJSON_new")
     */
    public function EditUserJSON(string $email,Request $request, NormalizerInterface $Normalizer,UserRepository $repository,UserPasswordEncoderInterface $encoder): Response
    {
        
           $user=$repository->findOneBy(['email' => $email]);
            
           
           $user->setPassword($request->get('password'));
           
           // $hash=$encoder->encodePassword($user,$request->get('password'));
        
            
            



            $entityManager = $this->getDoctrine()->getManager()->flush();
            

         $jsonContent=$Normalizer->normalize($user,'json',['groups'=>'post:read']);
            return new Response("user modifer  avec succés");
     }





    /**
     * @Route("/login/{email}/{password}", name="login")
     */
    public function login(string $email,string $password, Request $request, NormalizerInterface $Normalizer,UserRepository $repository)
    {   
        $user=$repository->findOneBy(['email' => $email,'password'=>$password]);
        $jsonContent=$Normalizer->normalize($user,'json',['groups'=>'post:read']);
        return new Response(json_encode($jsonContent,JSON_UNESCAPED_UNICODE));

    }





    /**
     * @Route("/", name="user_index", methods={"GET"})
     */
    public function index(UserRepository $userRepository): Response
    {
        return $this->render('user/index.html.twig', [
            'users' => $userRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="user_new", methods={"GET","POST"})
     */
    public function new(Request $request,UserPasswordEncoderInterface $encoder): Response
    {
        $user = new User();
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $hash=$encoder->encodePassword($user,$user->getPassword());
            $user->setPassword($hash);
            $entityManager->persist($user);
            $entityManager->flush();

            return $this->redirectToRoute('user_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('user/new.html.twig', [
            'user' => $user,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="user_show", methods={"GET"})
     */
    public function show(User $user): Response
    {
        return $this->render('user/show.html.twig', [
            'user' => $user,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="user_edit", methods={"GET","POST"})
     */
    public function edit(Request $request, User $user): Response
    {
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('user_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('user/edit.html.twig', [
            'user' => $user,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="user_delete", methods={"POST"})
     */
    public function delete(Request $request, User $user): Response
    {
        if ($this->isCsrfTokenValid('delete'.$user->getId(), $request->request->get('_token'))) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->remove($user);
            $entityManager->flush();
        }

        return $this->redirectToRoute('user_index', [], Response::HTTP_SEE_OTHER);
    }
     
}
