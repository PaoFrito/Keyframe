create table "user"(
    id serial, primary key (id),

    created_at timestamp default now(),
    updated_at timestamp default now(),
    last_login timestamp,
    is_active boolean default true,

    email varchar(50) unique not null,
    username varchar(50) not null,
    password varchar(100) not null,
    subs_count int default 0,
    avatar_path varchar(255) default './img/defaultAvatar.png'
);

create table subscription(
    id serial, primary key (id),

    subscribed_at timestamp default now(),
    is_active boolean default true,

    constraint fk_chanel foreign key (id) references "user" (id),
    constraint fk_subscriber foreign key (id) references  "user" (id)
);

create table video(
    id serial, primary key (id),

    title varchar(25) not null,
    thumbnail varchar(255) default './img/defaultThumbnail.png',
    description varchar(255) not null,
    view_count int default 0,
    comment_count int default 0,
    like_count int default 0,
    dislike_count int default 0,

    created_at timestamp default now(),
    constraint fk_created_by foreign key (id) references "user" (id),

    updated_at timestamp default now(),
    constraint fk_updated_by foreign key (id) references "user" (id),

    is_active boolean default true
);

create table playlist(
    id serial, primary key (id),
    title varchar(25) not null,
    description varchar(255) not null,
    video_count int default 0,
    is_playlist_public boolean default false,

    created_at timestamp default now(),
    constraint fk_posted_by foreign key (id) references "user" (id),
    updated_at timestamp default now(),
    constraint fk_updated_by foreign key (id) references "user" (id),
    is_active boolean default true
);

create table playlist_video(
    id serial, primary key (id),

    created_at timestamp default now(),
    is_active boolean default true,

    constraint fk_user_id foreign key (id) references "user" (id),
    constraint fk_video_id foreign key (id) references  video (id)
);

create table comment(
    id serial, primary key (id),

    content varchar(255) not  null,

    created_at timestamp default now(),
    constraint fk_user_id foreign key (id) references "user" (id),
    constraint fk_video_id foreign key (id) references  video (id),
    constraint fk_reference_comment foreign key (id) references comment (id)

);

create table evaluation(
    id serial, primary key (id),

    is_positive boolean,

    constraint fk_user_id foreign key (id) references "user" (id),
    constraint fk_video_id foreign key (id) references  video (id),
    constraint fk_reference_comment foreign key (id) references comment (id)
);

create table report(
    id serial, primary key (id),

    description varchar(255),
    type varchar(50),

    constraint fk_user_id foreign key (id) references "user" (id),
    constraint fk_video_id foreign key (id) references  video (id),
    constraint fk_reference_comment foreign key (id) references comment (id)

);