# Salary Lupin

![gif](https://github.com/user-attachments/assets/10a77c3d-a390-45d8-b71d-570dbd78d0c2)

![screenshot](https://github.com/user-attachments/assets/0911d540-aae4-4daf-b335-bbc0253d763b)

## About

Brackey Game Jam 에 제출하기 위해서 제작된 프로젝트로, 주제는 "Calm before the storm", 폭풍 전의 고요였습니다. 게임은 월급 루팡(일은 하지 않고 월급을 받는, 훔친다는 의미)에 대한 것으로, 출근 후 카드 게임 및 인터넷 쇼핑 등을 하며 시간을 떼우는 주인공 월급 루팡은 어느 날 착실히 모든 일을 다 하던 직원의 갑작스런 퇴사로 그 직원의 일을 떠맡게 되어 갑자기 바빠지는 상황을 그린 게임입니다. 3분 동안 카드 게임 등을 하며 대충 시간을 떼우다가 (calm) 갑자기 밀려드는 이메일과 서류작업(storm)을 퇴근 전까지 실수 없이 잘 마무리하는 게 게임의 목적입니다. 실수를 하게 되면 생명력을 잃게 되고, 이를 모두 잃으면 해고당합니다. 약 10,000명의 사람들이 이 게임잼에 참여했고, 1,493팀 중 총 338위를 하였으며 innovation 부문에서는 101위를 달성하며 좋은 성적을 거두었습니다. 
 
This project was for Brackey Game Jam with a game titled "Calm before the Storm." The game is about a salary lupin (a term referring to an employee who loses his or her salary without working) who plays according to the theme of "Calm before the Strom" spends time playing card games and online shopping after work as usual, and then suddenly becomes busy as the player takes on a lot of work after leaving the company unhappy with the company's elite employees doing a lot of work alone. After the game is played, you spend about three minutes(calm stage) playing card games, and then complete the tasks you receive by e-mail. About 10,000 people participated and ranked 338th overall out of 1,493 submitted games, and the project achieved a high result of 101st place in innovation.

<br>

## Information

- **Engine**: Godot
- **Platform**: WebgL
- **Team Size**: 1
- **Time Frame**: 1 week

<br>

## Features
시스템 | 설명
:--- | :---
🖥️ 컴퓨터 조작 <br><br> Computer Interaction | 모니터 클릭 시 다양한 애플리케이션 실행 가능 <br><br> Click the monitor to run different apps
📬 이메일 시스템 <br><br> Email System | 업무 지시가 이메일로 도착하며, 그냥 답장하거나 관련 파일 경로를 복사하여 파일과 함께 전송 <br><br> Work arrives via email — check instructions and find related files
📁 파일·폴더 시스템 <br><br> File & Folder System | 실제 폴더 구조처럼 파일 확인, 휴지통 기능 포함 <br><br> Manage files like a real OS; includes folders and trash bin
📝 문서 도장 처리 <br><br> Stamp Interaction | 스탬프를 찍는 인터랙션으로 서류 승인 <br><br> Use a stamp to approve or process documents
🕹️ 카드게임 <br><br> Card Game | 여유로운 초반을 위한 간단한 미니게임 내장 <br><br> A mini-game to pass time at the beginning
📅 시간 흐름 <br><br> Time Progression | 일정 시간마다 이벤트 발생 (업무 증가, 엔딩 조건 변화 등) <br><br> Events occur as in-game time passes (more tasks, ending triggers, etc.)
📊 작업 관리자 & 작업 표시줄 <br><br> Task Manager & Task Bar	| 실제 OS처럼 앱 간 전환 및 창 닫기 지원 <br><br> 	App switching and window control like a real desktop OS
📃 엔딩 시스템 <br><br> Ending System	| 일정 시간 생존 시 엔딩 화면 전환 <br><br> Game ends after surviving for a set amount of time

<br>

## Key Points
- **상태 기반 관리**: GameManager를 통해 시간, 메일 수, 생명 등 전역 상태를 통합 관리. <br> **Centralized State**: Global variables like time, email count, and life are managed through GameManager.
  
- **폴더 구조 재현**: 사용자가 실제로 폴더를 열고 닫고 정리하는 듯한 경험 제공. <br> **Realistic Folder Simulation**: User experience mimics a real OS with open/close and hierarchy logic.

- **시나리오 기반 설계**: 초반의 느긋함과 후반의 혼돈이 대비되도록 설계. <br> **Scenario Design**: Peaceful intro transitions into overwhelming work — thematic contrast is intentional.
  
- **UI 윈도우 시스템**: 창 드래그, 최소화, 우클릭 메뉴 등 인터랙션 구현. <br> **Window System**: Drag, minimize, and right-click menus enhance desktop-like interaction.

<br>

## Structure

```
📂 scripts/
├── GameManager.gd                                   # 전체 게임 상태 관리 (싱글톤)
│                                                      Global game state (singleton)
├── Start.gd / Ending.gd                             # 시작 및 엔딩 씬 로직
│                                                      Start and ending scene logic
├── CardGame.gd                                      # 카드 미니게임
│                                                      Simple card mini-game
├── ComputerManager.gd                               # 모니터 UI 및 앱 실행 제어
│                                                      Monitor & app interaction controller
├── TaskBar.gd / TaskManager.gd                      # 작업 표시줄 및 실행 중 앱 관리
│                                                      Task bar UI and running app handler
├── TimeNLife.gd                                     # 게임 내 시간 흐름 및 생명 수치 처리
│                                                      In-game time and life/stress manager
│
├── EmailClass.gd / EmailItem.gd / EmailManager.gd   # 이메일 시스템
│                                                      Email system
├── FileClass.gd / FolderItem.gd / FolderManager.gd  # 파일/폴더 시스템
│                                                      File & folder logic
├── BinManager.gd                                    # 휴지통 처리
│                                                      Trash bin behavior
│
├── PaperItem.gd / PapersItem.gd / StampedPaper.gd   # 문서 UI 및 스탬프 처리
│                                                      Paper & stamping UI
├── PaperManager.gd / PaperworkManager.gd            # 서류 생성 및 업무 처리
│                                                      Paperwork creation and handling
│
├── ClickObj.gd / RightClick.gd                       # 사용자 상호작용 처리
│                                                       User input (click & right-click)
├── MonitorView.gd                                    # 모니터 화면 전환 처리
                                                        Monitor view switching
```
<br>

#### <a href="https://www.youtube.com/watch?v=WHIqHyYsGUY&list=PLVgVcpUV3wTMd91EiLjE9PvgdMCfvKSws&index=15">▶️Play Video</a>
