<?php

namespace App\Repository;

use App\Entity\Cin;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Cin|null find($id, $lockMode = null, $lockVersion = null)
 * @method Cin|null findOneBy(array $criteria, array $orderBy = null)
 * @method Cin[]    findAll()
 * @method Cin[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CinRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Cin::class);
    }

    // /**
    //  * @return Cin[] Returns an array of Cin objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('c.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Cin
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
    public function getNbreCin(): int
    {
        $entityManager = $this->getEntityManager();

        $query = $entityManager->createQuery(
            "SELECT count(c)
            FROM App\Entity\cin c"
        )->getResult();
        // returns an array of Product objects
        return $query[0][1];
    }
}
