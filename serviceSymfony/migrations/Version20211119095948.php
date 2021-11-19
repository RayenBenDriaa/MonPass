<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20211119095948 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE user ADD cin_id INT DEFAULT NULL, ADD passeport_id INT DEFAULT NULL, ADD facture_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE user ADD CONSTRAINT FK_8D93D649E9795579 FOREIGN KEY (cin_id) REFERENCES cin (id)');
        $this->addSql('ALTER TABLE user ADD CONSTRAINT FK_8D93D649691B94D5 FOREIGN KEY (passeport_id) REFERENCES passeport (id)');
        $this->addSql('ALTER TABLE user ADD CONSTRAINT FK_8D93D6497F2DEE08 FOREIGN KEY (facture_id) REFERENCES facture (id)');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_8D93D649E9795579 ON user (cin_id)');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_8D93D649691B94D5 ON user (passeport_id)');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_8D93D6497F2DEE08 ON user (facture_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE user DROP FOREIGN KEY FK_8D93D649E9795579');
        $this->addSql('ALTER TABLE user DROP FOREIGN KEY FK_8D93D649691B94D5');
        $this->addSql('ALTER TABLE user DROP FOREIGN KEY FK_8D93D6497F2DEE08');
        $this->addSql('DROP INDEX UNIQ_8D93D649E9795579 ON user');
        $this->addSql('DROP INDEX UNIQ_8D93D649691B94D5 ON user');
        $this->addSql('DROP INDEX UNIQ_8D93D6497F2DEE08 ON user');
        $this->addSql('ALTER TABLE user DROP cin_id, DROP passeport_id, DROP facture_id');
    }
}
