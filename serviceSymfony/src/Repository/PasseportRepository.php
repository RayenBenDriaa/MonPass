<?php

namespace App\Repository;

use App\Entity\Passeport;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Passeport|null find($id, $lockMode = null, $lockVersion = null)
 * @method Passeport|null findOneBy(array $criteria, array $orderBy = null)
 * @method Passeport[]    findAll()
 * @method Passeport[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PasseportRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Passeport::class);
    }

    // /**
    //  * @return Passeport[] Returns an array of Passeport objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('p.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Passeport
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
