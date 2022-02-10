# seoulauction front
서울 옥션 웹페이지 프로젝트 입니다.

## Getting Started

> `VPN`,`권한` 등 사전에 모든 설정 부분이 완료되어 있어야 합니다.
> 

```bash
# 저장소를 Clone
git clone ssh://git@gitlab.ssh.bid:10020/seoulauction-legacy/front/service_seoulauction.front.git
```

---

## Git Strategy

### 전체 브랜치
- master
- develop
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
