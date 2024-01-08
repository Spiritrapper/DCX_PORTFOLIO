from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import scoped_session, sessionmaker

db = SQLAlchemy()

def create_session():
    return scoped_session(sessionmaker(
        autocommit=False,
        autoflush=False,
        bind=db.engine
    ))
