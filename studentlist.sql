PGDMP                  	    |            studentrecord    17rc1    17rc1 *    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16388    studentrecord    DATABASE     o   CREATE DATABASE studentrecord WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE studentrecord;
                     postgres    false            �            1259    16408 
   curriculum    TABLE     �   CREATE TABLE public.curriculum (
    curr_name_th character varying(50),
    curr_name_en character varying(50),
    short_name_th character varying(50),
    short_name_en character varying(50),
    id integer NOT NULL
);
    DROP TABLE public.curriculum;
       public         heap r       postgres    false            �            1259    16457    curriculum_id_seq    SEQUENCE     �   CREATE SEQUENCE public.curriculum_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.curriculum_id_seq;
       public               postgres    false    221            �           0    0    curriculum_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.curriculum_id_seq OWNED BY public.curriculum.id;
          public               postgres    false    226            �            1259    16397    prefix    TABLE     Z   CREATE TABLE public.prefix (
    id integer NOT NULL,
    prefix character varying(10)
);
    DROP TABLE public.prefix;
       public         heap r       postgres    false            �            1259    16396    prefix_id_seq    SEQUENCE     �   CREATE SEQUENCE public.prefix_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.prefix_id_seq;
       public               postgres    false    220            �           0    0    prefix_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.prefix_id_seq OWNED BY public.prefix.id;
          public               postgres    false    219            �            1259    16424    section    TABLE     S   CREATE TABLE public.section (
    id integer NOT NULL,
    section character(2)
);
    DROP TABLE public.section;
       public         heap r       postgres    false            �            1259    16423    section_id_seq    SEQUENCE     �   CREATE SEQUENCE public.section_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.section_id_seq;
       public               postgres    false    225            �           0    0    section_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.section_id_seq OWNED BY public.section.id;
          public               postgres    false    224            �            1259    16390    student    TABLE     �  CREATE TABLE public.student (
    id integer NOT NULL,
    prefix_id smallint,
    first_name character varying(50),
    last_name character varying(50),
    date_of_birth date,
    sex smallint,
    curriculum_id smallint,
    previous_school character varying(50),
    address character varying(100),
    telephone character(10),
    email character varying(50),
    line_id character varying(50)
);
    DROP TABLE public.student;
       public         heap r       postgres    false            �            1259    16389    student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.student_id_seq;
       public               postgres    false    218            �           0    0    student_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;
          public               postgres    false    217            �            1259    16412    student_list    TABLE     �   CREATE TABLE public.student_list (
    id integer NOT NULL,
    section_id smallint,
    student_id character(13),
    active_date date
);
     DROP TABLE public.student_list;
       public         heap r       postgres    false            �            1259    16411    student_list_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.student_list_id_seq;
       public               postgres    false    223            �           0    0    student_list_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.student_list_id_seq OWNED BY public.student_list.id;
          public               postgres    false    222            7           2604    16458    curriculum id    DEFAULT     n   ALTER TABLE ONLY public.curriculum ALTER COLUMN id SET DEFAULT nextval('public.curriculum_id_seq'::regclass);
 <   ALTER TABLE public.curriculum ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    221            6           2604    16400 	   prefix id    DEFAULT     f   ALTER TABLE ONLY public.prefix ALTER COLUMN id SET DEFAULT nextval('public.prefix_id_seq'::regclass);
 8   ALTER TABLE public.prefix ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219    220            9           2604    16427 
   section id    DEFAULT     h   ALTER TABLE ONLY public.section ALTER COLUMN id SET DEFAULT nextval('public.section_id_seq'::regclass);
 9   ALTER TABLE public.section ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    225    225            5           2604    16493 
   student id    DEFAULT     h   ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);
 9   ALTER TABLE public.student ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            8           2604    16481    student_list id    DEFAULT     r   ALTER TABLE ONLY public.student_list ALTER COLUMN id SET DEFAULT nextval('public.student_list_id_seq'::regclass);
 >   ALTER TABLE public.student_list ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    222    223            �          0    16408 
   curriculum 
   TABLE DATA           b   COPY public.curriculum (curr_name_th, curr_name_en, short_name_th, short_name_en, id) FROM stdin;
    public               postgres    false    221   �.       �          0    16397    prefix 
   TABLE DATA           ,   COPY public.prefix (id, prefix) FROM stdin;
    public               postgres    false    220   y/       �          0    16424    section 
   TABLE DATA           .   COPY public.section (id, section) FROM stdin;
    public               postgres    false    225   �/       �          0    16390    student 
   TABLE DATA           �   COPY public.student (id, prefix_id, first_name, last_name, date_of_birth, sex, curriculum_id, previous_school, address, telephone, email, line_id) FROM stdin;
    public               postgres    false    218   �/       �          0    16412    student_list 
   TABLE DATA           O   COPY public.student_list (id, section_id, student_id, active_date) FROM stdin;
    public               postgres    false    223   �2       �           0    0    curriculum_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.curriculum_id_seq', 1, false);
          public               postgres    false    226            �           0    0    prefix_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.prefix_id_seq', 1, false);
          public               postgres    false    219            �           0    0    section_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.section_id_seq', 1, false);
          public               postgres    false    224            �           0    0    student_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.student_id_seq', 7, true);
          public               postgres    false    217            �           0    0    student_list_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.student_list_id_seq', 1, false);
          public               postgres    false    222            ?           2606    16460    curriculum curriculum_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.curriculum DROP CONSTRAINT curriculum_pkey;
       public                 postgres    false    221            =           2606    16402    prefix prefix_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.prefix
    ADD CONSTRAINT prefix_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.prefix DROP CONSTRAINT prefix_pkey;
       public                 postgres    false    220            C           2606    16429    section section_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.section DROP CONSTRAINT section_pkey;
       public                 postgres    false    225            A           2606    16483    student_list student_list_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_pkey;
       public                 postgres    false    223            ;           2606    16495    student student_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public                 postgres    false    218            D           2606    16496    prefix prefix_id_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY public.prefix
    ADD CONSTRAINT prefix_id_fkey FOREIGN KEY (id) REFERENCES public.student(id);
 ?   ALTER TABLE ONLY public.prefix DROP CONSTRAINT prefix_id_fkey;
       public               postgres    false    218    4667    220            F           2606    16501    section section_id_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_id_fkey FOREIGN KEY (id) REFERENCES public.student(id);
 A   ALTER TABLE ONLY public.section DROP CONSTRAINT section_id_fkey;
       public               postgres    false    225    4667    218            E           2606    16506 !   student_list student_list_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_id_fkey FOREIGN KEY (id) REFERENCES public.student(id);
 K   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_id_fkey;
       public               postgres    false    4667    218    223            �   �   x������@��ݧ��4����ZKYV�-����FD���A
Ea�6��Gb�B�����f@{�	�~@GP��Z�bds�t -Av�?�o���)k��R��e��C�W�ںg�.T��:0VXUw��xd¢&8!��>|Uy;�5��sB���@}u	׬��C�_׬��:���<��v\8h�gU��u}ם���z�}�����ʖ/�� ��>�      �   )   x�3�|�c���X�eg�s#�v�3�s��qqq �V,      �      x�3�t�2������� �e      �   �  x�u��n�0Ư�S�l ��=Ȥȡ����4��Oj��nZ�]LZ�iS�Ik�I�m�(;vLF�MA:q���w>#�:ֲ���(+(�(�sD��xA��aXA����j�f�z�����{%��s��o%�(�	)&aϓt���W������.�
�@�m)?�H��R��#c��H��Q���P�W�Qϒ��G%�*y��J^�`auc__Ltmm��N�B��Ѳn9b\hu-z��H�xOyٯi�r����5"�@���?���܍`� �������w�����Њvh��>+��xa �H��Vn����;�)9���%S�J>3/_��5/W�`�h5�̈́l,f�S'���̤k�(t>�p��éI����Gt���bq �\�E o�w��n�nk��q�о��.�̛�1�M$�`a�aa[�=D���Z�J^+yaFrk�qc8�Xr��70�]�YY�p'�7���l;�>�oi���Z�5�f`8%ƌ�Z��`	��NͰ11���r�-�%��ʞ5�Ҳ��
'�Dpc<*����6���E_A�9Q���(�A/�՘���5�X��j��g[Z�����'�dB0�48V�!��)j�	]T�=g�y�1q���?}�S�KO�9@X��Nac,.+�����t=���mB�.�`L��1��`��S�$���{3<Q�ۮux��v�p|/���[[v���C�q�?�:�      �      x������ � �     