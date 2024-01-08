from flask import Blueprint, Response
from flask import Flask, render_template, Response
import numpy as np
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import scoped_session, sessionmaker
from flask import current_app


video_stream_blueprint = Blueprint('video_stream', __name__)

db = SQLAlchemy()
def create_session():
    return scoped_session(sessionmaker(
        autocommit=False,
        autoflush=False,
        bind=db.engine
    ))


@video_stream_blueprint.route('/video_feed')
def video_feed():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

def generate_frames():
    with current_app.app_context():
        # 라우트 내부에서 호출되는 함수 내에서 create_session 사용
        session = create_session()
        # generate_frames 로직을 구현하세요.
