# Dependency



## Dependency

- A object 내에서 B object를 변수로 가지고 있거나 parameter로 받거나 B의 메소드를 사용하는 경우에 A는 B에 의존성이 있다고 한다.
- 의존성이 높으면(많으면?) 재 사용하기도 어렵고 테스트 하기도 어렵다.
- 최대한 각각의 오브젝트를 독립적으로 만들고 의존성을 끊는게 좋다.
- 이 오브젝트(클래스)를 수정 없이 다른 곳에서 재 사용 할 수 있다면 의존성이 없다고 할 수 있다.



## Dependency Injection(DI)

- 의존성이 있는 상태에서, 직접 생성하는 대신에 외부에서 주입 받도록 한다.

- DI 방법이 크게 3가지 있지만, 주로 생성할 때 넣는 방법을 사용한다.

- Constructor Injection

  - swift에는 initializer가 있기 때문에 Initializer Injection 으로 부른다.

  ```swift
  Car.init(tire: SnowTire()) 
  ```

- property Injection

  - 클래스 내부에서 변수로 가지고 있으면, 외부에서 생성에서 등록

  ```swift
  car.tire = SnowTire()
  ```

- Method injection

  - 클래스 내부에서 함수를 만들어서 주입 받음

  ```swift
  car.setupTire(SnowTire())
  ```



## Dependency Inversion Principle(DIO)

- 의존성 역전의 원칙
- 의존하고 있는 오브젝트를 인터페이스로 분리해서 의존성을 끊고, 인터페이스를 reference하도록 변경
- DI + 추상화
- 클래스 내부에 객체가 그대로 사용되고 있으면, 비슷한 기능을 하는 다른 객체가 들어오면 재사용 하기가 어려움. 추상화를 시켜서 사용하면 재사용 확장이 가능함.



## Resolver

- Swift에서 사용하는 depency injection library
- IOC인듯. 하나의 container를 가지고 거기에 등록을 하고 다른 곳에서 사용할 수 있도록
- 구현하는 방법이 여러개 있지만, property wrapper를 사용해서 annotation을 이용한 방법을 사용할 수 있다.
- Resolver에 다른 곳에서도 사용할 오브젝트를 저장해두고, 다른 클래스 내부에서는 @Injected 라는 property wrapper를 이용해서 접근해서 꺼내서 사용
- 매번 객체를 생성하지 않고, 한 번 생성한 후 한 군데서 모아서 관리



#### 참고

- Depency란? (Swift 코드 예시): https://develogs.tistory.com/19?category=589493
- IoC 전반적인 정리: [https://wotjd.github.io/2019/05/architecture-ioc-%EA%B4%80%EB%A0%A8-%EB%81%84%EC%A0%81-ioc-di-dip-ioc-container/](https://wotjd.github.io/2019/05/architecture-ioc-관련-끄적-ioc-di-dip-ioc-container/)
- DI 설명: https://medium.com/@jang.wangsu/di-dependency-injection-이란-1b12fdefec4f
- DI 종류 : https://eunjin3786.tistory.com/115
- 의존성 주입하기: https://speakerdeck.com/devxoul/regeosi-peurojegteueseo-yijonseong-juibhagi?slide=83
- Resolver: https://github.com/hmlongco/Resolver