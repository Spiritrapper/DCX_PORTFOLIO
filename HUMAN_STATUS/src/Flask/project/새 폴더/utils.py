# utils.py
import mysql.connector

def connect_to_database():
    return mysql.connector.connect(
        host="project-db-campus.smhrd.com",
        port=3312,
        user="seocho_22K_DCX_final_2",
        password="smhrd2",
        database="seocho_22K_DCX_final_2"
    )