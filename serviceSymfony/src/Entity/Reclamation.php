<?php

namespace App\Entity;

use App\Repository\ReclamationRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;

/**
 * @ORM\Entity(repositoryClass=ReclamationRepository::class)
 */
class Reclamation
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     * @Groups("post:read")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=User::class, inversedBy="reclamations")
     * @ORM\JoinColumn(nullable=false)
     * @Groups("post:read")
     */
    private $user;

    /**
     * @ORM\Column(type="string", length=255)
     * @Groups("post:read")
     */
    private $descriptionReclamation;

    /**
     * @ORM\ManyToOne(targetEntity=Typereclamation::class, inversedBy="reclamations")
     * @ORM\JoinColumn(nullable=false)
     * @Groups("post:read")
     */
    private $typeReclamation;

    /**
     * @ORM\Column(type="date")
     * @Groups("post:read")
     */
    private $dateReclamation;

    /**
     * @ORM\Column(type="integer")
     * @Groups("post:read")
     */
    private $encours;

    /**
     * @ORM\Column(type="integer")
     * @Groups("post:read")
     */
    private $traite;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): self
    {
        $this->user = $user;

        return $this;
    }

    public function getDescriptionReclamation(): ?string
    {
        return $this->descriptionReclamation;
    }

    public function setDescriptionReclamation(string $descriptionReclamation): self
    {
        $this->descriptionReclamation = $descriptionReclamation;

        return $this;
    }

    public function getTypeReclamation(): ?Typereclamation
    {
        return $this->typeReclamation;
    }

    public function setTypeReclamation(?Typereclamation $typeReclamation): self
    {
        $this->typeReclamation = $typeReclamation;

        return $this;
    }

    public function getDateReclamation(): ?\DateTimeInterface
    {
        return $this->dateReclamation;
    }

    public function setDateReclamation(\DateTimeInterface $dateReclamation): self
    {
        $this->dateReclamation = $dateReclamation;

        return $this;
    }

    public function getEncours(): ?int
    {
        return $this->encours;
    }

    public function setEncours(int $encours): self
    {
        $this->encours = $encours;

        return $this;
    }

    public function getTraite(): ?int
    {
        return $this->traite;
    }

    public function setTraite(int $traite): self
    {
        $this->traite = $traite;

        return $this;
    }
}
