<?php

namespace App\Repository;

use App\Entity\Typereclamation;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Typereclamation|null find($id, $lockMode = null, $lockVersion = null)
 * @method Typereclamation|null findOneBy(array $criteria, array $orderBy = null)
 * @method Typereclamation[]    findAll()
 * @method Typereclamation[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class TypereclamationRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Typereclamation::class);
    }

    // /**
    //  * @return Typereclamation[] Returns an array of Typereclamation objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('t')
            ->andWhere('t.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('t.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Typereclamation
    {
        return $this->createQueryBuilder('t')
            ->andWhere('t.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
