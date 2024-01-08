import vlc
import time

# VLC 인스턴스 생성
instance = vlc.Instance()

# 미디어 플레이어 생성
player = instance.media_player_new()

# 스트림 URL 설정
stream_url = "http://127.0.0.1:3000/"  # 실제 스트리밍 URL로 대체해야 합니다
media = instance.media_new(stream_url)
player.set_media(media)

# 미디어 플레이어 윈도우 생성 (화면에 표시되지 않도록 설정)
player.set_xid(0)

# 미디어 재생 시작
player.play()

# 재생을 일정 시간동안 유지 (예: 10초)
time.sleep(10)

# 미디어 재생 중지
player.stop()