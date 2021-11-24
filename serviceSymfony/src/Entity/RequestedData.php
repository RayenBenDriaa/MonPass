<?php

namespace App\Entity;

use App\Repository\RequestedDataRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;

/**
 * @ORM\Entity(repositoryClass=RequestedDataRepository::class)
 */
class RequestedData
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     * @Groups("post:read")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     * @Groups("post:read")
     */
    private $fromWho;

    /**
     * @ORM\Column(type="string", length=255)
     * @Groups("post:read")
     */
    private $ofWho;

    /**
     * @ORM\Column(type="string", length=255)
     * @Groups("post:read")
     */
    private $approval;

    /**
     * @ORM\Column(type="date")
     * @Groups("post:read")
     */
    private $date;

    /**
     * @ORM\Column(type="string", length=3)
     * @Groups("post:read")
     */
    private $cin;

    /**
     * @ORM\Column(type="string", length=3)
     * @Groups("post:read")
     */
    private $passeport;

    /**
     * @ORM\Column(type="string", length=3)
     * @Groups("post:read")
     */
    private $facture;

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

    public function getCin(): ?string
    {
        return $this->cin;
    }

    public function setCin(string $cin): self
    {
        $this->cin = $cin;

        return $this;
    }

    public function getPasseport(): ?string
    {
        return $this->passeport;
    }

    public function setPasseport(string $passeport): self
    {
        $this->passeport = $passeport;

        return $this;
    }

    public function getFacture(): ?string
    {
        return $this->facture;
    }

    public function setFacture(string $facture): self
    {
        $this->facture = $facture;

        return $this;
    }
}
