-- CreateTable
CREATE TABLE chat (
    id SERIAL PRIMARY KEY,
    user_id BIGINT NULL,
    content TEXT NULL,
    room_id VARCHAR(50) NULL,
    date TIMESTAMP NULL
);

-- CreateTable
CREATE TABLE code (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NULL,
    expired TIMESTAMP NULL
);

-- CreateTable
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    avatar TEXT NULL,
    pass_word VARCHAR(255) NOT NULL,
    face_app_id VARCHAR(255) NULL,
    role VARCHAR(50) DEFAULT 'user',
    refresh_token TEXT NULL
);

-- CreateTable
CREATE TABLE video_comment (
    comment_id SERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    video_id BIGINT NOT NULL,
    date_create TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content TEXT NULL,
    reply_list TEXT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE video_like (
    like_id SERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    video_id BIGINT NOT NULL,
    date_create TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dis_like BOOLEAN DEFAULT FALSE
);

-- CreateTable
CREATE TABLE video_type (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(255) NOT NULL,
    icon TEXT NULL
);

-- CreateTable
CREATE TABLE video (
    video_id SERIAL PRIMARY KEY,
    video_name VARCHAR(255) NOT NULL,
    thumbnail TEXT NULL,
    description TEXT NULL,
    views BIGINT DEFAULT 0,
    source TEXT NULL,
    user_id BIGINT NOT NULL,
    type_id BIGINT NOT NULL
);

-- AddForeignKey and Constraints
ALTER TABLE code
    ADD CONSTRAINT code_unique UNIQUE (code);

-- ✅ ON DELETE CASCADE: Tự động xóa các bản ghi liên quan trong bảng con khi bản ghi trong bảng cha bị xóa.
-- ✅ ON UPDATE CASCADE: Tự động cập nhật giá trị cột trong bảng con khi giá trị khóa chính trong bảng cha thay đổi.
ALTER TABLE video_comment
    ADD CONSTRAINT fk_video_comment_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT fk_video_comment_video FOREIGN KEY (video_id) REFERENCES video(video_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE video_like
    ADD CONSTRAINT fk_video_like_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT fk_video_like_video FOREIGN KEY (video_id) REFERENCES video(video_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE video
    ADD CONSTRAINT fk_video_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT fk_video_type FOREIGN KEY (type_id) REFERENCES video_type(type_id) ON DELETE CASCADE ON UPDATE CASCADE;
