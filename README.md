# 화장품 성분 분석 플랫폼

## 실행 방법

### 1. 패키지 설치
```bash
pip3 install fastapi uvicorn groq
```

### 2. Groq API 키 설정
```bash
export GROQ_API_KEY="your-groq-key-here"
```

### 3. 서버 실행
```bash
uvicorn server:app --reload
```

### 4. UI 연결
cosmetic_app.jsx 를 React 프로젝트에 넣고 실행하면
http://localhost:8000 서버와 자동으로 연결돼요.

## 터미널에서 바로 실행 (UI 없이)
```bash
python3 run.py
```
