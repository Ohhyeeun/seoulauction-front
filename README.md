# seoulauction front
서울 옥션 웹페이지 프로젝트 입니다.

## Getting Started
```bash
# 저장소를 Clone
git clone https://github.com/seoulauction/seoulauction-front.git
```

---

## Git Strategy

### 전체 브랜치
- master
- develop ( 현재 사용 x 2022-03-19 )
- dev ( 2022-03-19 )
- feature/...
- hotfix/...

### origin/master
운영 브랜치

### 현재 버전에서 수정 사항 반영 시

```
                                  (new branch)      (merge request)   
- master                      ─────o────────────────o─────────────────────
- hotfix/fix-blah-blah-error  	   └───o───o───o────┘
```

### origin/develop
1차 리뉴얼 브랜치

### 1차 리뉴얼 버전에서 새로운 기능을 추가할 때

```
                                  (new branch)      (merge request)   
- develop                      ─────o────────────────o─────────────────────
- feature/add-social-login  	    └───o───o───o────┘
```

---

## Server Information
TODO...

---

## Development
TODO...

---

## Build
TODO...

---

## Deployment
TODO...
