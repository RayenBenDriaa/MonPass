<?php

namespace App\Entity;

use App\Repository\RequestedDataRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=RequestedDataRepository::class)
 */
class RequestedData
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $fromWho;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $ofWho;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $approval;

    /**
     * @ORM\Column(type="date")
     */
    private $date;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getFromWho(): ?string
    {
        return $this->fromWho;
    }

    public function setFromWho(string $fromWho): self
    {
        $this->fromWho = $fromWho;

        return $this;
    }

    public function getOfWho(): ?string
    {
        return $this->ofWho;
    }

    public function setOfWho(string $ofWho): self
    {
        $this->ofWho = $ofWho;

        return $this;
    }

    public function getApproval(): ?string
    {
        return $this->approval;
    }

    public function setApproval(string $approval): self
    {
        $this->approval = $approval;

        return $this;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(\DateTimeInterface $date): self
    {
        $this->date = $date;

        return $this;
    }
}
