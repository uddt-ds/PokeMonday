
# 포켓먼데이(PokemonDay)

### 📍 프로젝트 소개

매일매일 포켓몬스터만 생각하고 살고 있는 당신을 위한 앱.
RxSwift를 사용한 포켓몬스터 도감 앱입니다.
<p align="center">
  <img src="https://github.com/uddt-ds/PokeMonday/blob/main/PokeMondayImage.png" alt="PokeMondayImage.png" width="1280">
</p>

> 내용 :
> 포켓몬스터의 전체 이미지와 정보를 확인할 수 있습니다.
> 이미지를 누르면 해당 포켓몬의 타입과 이름 등의 정보를 확인할 수 있습니다.
> 

  ### 📍 프로젝트에 사용한 스택
> <img src="https://img.shields.io/badge/XCode-147EFB?style=for-the-badge&logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white"> <img src="https://img.shields.io/badge/RXSwift-B7178C?style=for-the-badge&logo=ReactiveX&logoColor=white"> <img src="https://img.shields.io/badge/UIKIT-2396F3?style=for-the-badge&logo=UIKIT&logoColor=white"> <img src="https://img.shields.io/badge/GIthub-181717?style=for-the-badge&logo=GITHUB&logoColor=white">
  
### 📍 프로젝트 개발 기간과 버전 업데이트
> #### 기획:
>  스파르타 코딩클럽 iOS 과정의 과제로 본 프로젝트를 시작하였습니다.
>  
> #### 개발: 
> 2025/05/11 ~ 2025/05/19(약 8일간)
  
###  📍 목차

>  ### [1. 프로젝트 의의]
> RxSwift를 사용하여 반응형 프로그래밍을 설계하고 구현합니다.
> RxCocoa를 사용하여 UI 컴포넌트를 리팩토링하고, 
> 'button.rx.tap' 등과 같은 구문으로 버튼 이벤트를 구독하여 반응형 UI로 구성합니다.
> 
> 이를 통해 기존 절차형 프로그래밍에서 사용하는 addTarget이나 @objc 메서드 방식을 넘어
> 데이터의 흐름과 UI 스트림을 중심으로 하는 반응형 프로그래밍의 개념을 이해하고,
> Observable 객체와의 상호작용 기반 코드를 작성합니다.
>
>  
> ### [2. 프로젝트 기능]
> 메인화면을 아래로 스크롤하여 포켓몬스터의 이미지를 확인할 수 있습니다.
> 해당 포켓몬스터를 클릭하면 상세 정보(이름, 타입, 무게 등)를 확인할 수 있습니다.
> 
 > ### [3. 프로젝트의 파일구조]
```
.
├── PokeMonday
│   ├── App
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   └── Contents.json
│   │   ├── Contents.json
│   │   └── pokemonBall.imageset
│   │       ├── Contents.json
│   │       └── pokemonBall.png
│   ├── Base
│   │   ├── BaseCollectionViewCell.swift
│   │   └── BaseViewController.swift
│   ├── Common
│   │   └── Color.swift
│   ├── Data
│   │   └── NetworkManager.swift
│   ├── Detail
│   │   ├── DetailView.swift
│   │   └── DetailViewController.swift
│   ├── Error
│   │   └── NetworkError.swift
│   ├── Main
│   │   ├── MainCollectionViewCell.swift
│   │   └── MainViewController.swift
│   ├── Model
│   │   ├── DetailPokeData.swift
│   │   ├── LimitPokeData.swift
│   │   └── PokemonTranslator.swift
│   └── ViewModel
│       ├── DetailViewModel.swift
│       └── MainViewModel.swift
```
>
> 
###  📍 프로젝트를 마치며
> ### [1. 트러블 슈팅]
> [프로젝트 일지 + 트러블 슈팅] https://uddt.tistory.com/271
> [RxCocoa 사용 중 버튼이 스스로 눌리는 현상] https://uddt.tistory.com/274
>
> ### [2. 소회]
> 기존의 addTarget, @objc 메서드의 사용에서 벗어나 
> button.rx.tap 구문으로 쉽게 구현이 된다는 점에서 흥미로운 프로젝트였습니다.
> 처음 Rx를 접했을 때 '반응형 프로그래밍'이라는 말이 와닿지 않았는데,
> 직접 구현하면서 데이터나 버튼 이벤트를 구독하고,
> 상태 변화(데이터 방출, 버튼 이벤트 발생 등)에 따라 프로그램이 유기적으로 움직이는 것을 보며
> 반응형 프로그래밍을 더욱 이해하고, Rx를 공부할 수 있는 좋은 시간이었습니다.
