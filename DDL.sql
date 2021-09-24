create schema veterinario;

create user 'user'@'localhost' identified by 'pass123';

grant select, insert, delete, update on veterinario.* to user@'localhost';

use veterinario;

create table ani_animal (
    ani_id bigint unsigned not null auto_increment,
    ani_nome varchar(100) not null,
    ani_especie varchar(100) not null,
    ani_data_nascimento datetime not null,
    primary key (ani_id)
);

create table don_dono (
    don_id bigint unsigned not null auto_increment,
    don_nome varchar(100) not null,
    don_telefone bigint not null,
    don_email varchar(100),
    primary key (don_id),
    unique key uni_dono_telefone (don_telefone)
);

create table ado_animal_dono (
    ani_id bigint unsigned not null,
    don_id bigint unsigned not null,
    primary key (ani_id, don_id),
    foreign key ado_ani_fk (ani_id)
        references ani_animal (ani_id)
        on delete restrict on update cascade,
    foreign key ado_don_fk (don_id)
        references don_dono (don_id)
        on delete restrict on update cascade
);

create table con_consulta (
    con_id bigint unsigned not null auto_increment,
    con_data datetime not null,
    con_procedimento varchar(200) not null,
    ani_id bigint unsigned not null,
    primary key (con_id),
    foreign key con_ani_fk (ani_id)
        references ani_animal (ani_id)
        on delete restrict on update cascade
);

create table usr_usuario (
    usr_id bigint unsigned not null auto_increment,
    usr_nome varchar(20) not null,
    usr_email varchar(100) not null,
    usr_senha varchar(100) not null,
    primary key (usr_id),
    unique key uni_usuario_nome (usr_nome),
    unique key uni_usuario_email (usr_email)
);

create table aut_autorizacao (
    aut_id bigint unsigned not null auto_increment,
    aut_nome varchar(20) not null,
    primary key (aut_id),
    unique key uni_aut_nome (aut_nome)
);

create table uau_usuario_autorizacao (
    usr_id bigint unsigned not null,
    aut_id bigint unsigned not null,
    primary key (usr_id, aut_id),
    foreign key uau_usr_fk (usr_id)
        references usr_usuario (usr_id)
        on delete restrict on update cascade,
    foreign key uau_aut_fk (aut_id)
        references aut_autorizacao (aut_id)
        on delete restrict on update cascade
);