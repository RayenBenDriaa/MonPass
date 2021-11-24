<?php

namespace App\Repository;

use App\Entity\RequestedData;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RequestedData|null find($id, $lockMode = null, $lockVersion = null)
 * @method RequestedData|null findOneBy(array $criteria, array $orderBy = null)
 * @method RequestedData[]    findAll()
 * @method RequestedData[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RequestedDataRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RequestedData::class);
    }

    // /**
    //  * @return RequestedData[] Returns an array of RequestedData objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('r.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?RequestedData
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
