<?php

namespace App\Repository;

use App\Entity\DummyUser;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DummyUser|null find($id, $lockMode = null, $lockVersion = null)
 * @method DummyUser|null findOneBy(array $criteria, array $orderBy = null)
 * @method DummyUser[]    findAll()
 * @method DummyUser[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DummyUserRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DummyUser::class);
    }

    // /**
    //  * @return DummyUser[] Returns an array of DummyUser objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('d.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?DummyUser
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
