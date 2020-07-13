# Ch4. Delegation Pattern

- delegate pattern을 이용하면 직접 데이터를 제공하고 일을 수행하는 대신에, 다른 helper 오브젝트를 이용해서 대신하게 할 수 있다.

   ![ch4-1](./assets/ch4-1.png)

- **Object Needing a Delegate(delegating object)**
  - delegate를 가지고 있는 오브젝트
  - retain cycle를 피하기 위해서 주로 weak property로 delegate를 들고 있다. 
- **Delegate protocol**
  
  - implement 해야할 함수들을 정의한 protocol 
- **Delegate**
  
  - delegate protocol를 implement한 helper 오브젝트 



## When Should you use it? 

- 큰 클래스를 나누거나 generic을 만들거나 재 사용 가능한 component를 만들 때 delegate pattern을 사용하면 된다. 
- UIKit에서는 delegate pattern을 자주 사용한다. 
- **DataSource**
  - data를 제공할 때 사용
- **Delegate**
  - 데이터나 이벤트를 전달 받을 때 사용 



## Playground example

- playground에서 MenuVC delegate 구현.



## What should you be careful about?

- delegate를 남용하는 걸 조심해야 한다. 
  - 하나의 오브젝트에 너무 많은 delegate가 있다고 느껴지면 오브젝트를 나누는 것이 좋다. 
- retain cycle를 만들지 않도록 조심해야 한다. 
  - 대부분의 경우에 delegate property는 `weak` 여야 한다. 
  - 만약 strong delegate를 사용하려고 하면, 다른 디자인 패턴이 더 적합한지 고민해 봐야 한다.(ex. strategy pattern)



## Tutorial project

- RabbleWabble 프로젝트에서 tableViewDelegate / custom delegate 구현 

- Hugging Priority / Compression Resistance Priority

  - 우선순위가 높으면 내 크기를 지킨다!

  - **Hugging priority**
    - 우선순위가 낮으면 크기가 늘어난다.

  - **Compression Resistance priority**
    - 우선순위가 낮으면 크기가 줄어든다.



## Key Points

- delegate pattern의 3가지 요소
  - delegate가 필요한 object
  - delegate protocol 
  - delegate 
- delegate pattern을 이용하면 큰 클래스를 쪼갤 수 있고, 제네릭하고 재사용 가능한 컴포넌트를 만들 수 있다. 
- delegate는 `weak` 프로퍼티여야 한다! 