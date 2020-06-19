# Push Notifications

## Chapter3. Remote Notification Payload

- **push**는 인터넷을 통해 데이터를 보내면서 일어나는데, 이 때 데이터를 **payload** 라고 함. 

- Apple은 payload struct로 JSON을 사용함. JSON을 사용하므로써 쉽게 파싱하고 유연하게 대응할 수 있음.

- 일반적인 remote notification의 최대 payload size는 4KB.(VoIP는 최대 5KB)

  이 크기보다 크면 Apple이 거절하고 APNs로 부터 error를 받음.



### The aps dictionary key

- payload에 필요한 것들이 aps dictionary에 저장되어 있음.
- 이 key를 이용해서 다음과 같은 아이템을 설계할 수 있음.
  - end user에게 보여 줄 message
  - app badge number
  - sound
  - user interface의 결과 



#### Alert

- alert key 

- 주로 title과 body를 포함. 

  ```json
  {
      "aps": {
          "alert": {
              "title": "Your food is done.",
              "body": "Be careful, it's really hot!"
          }
      }
  }
  ```



##### Localization 

- Localization을 위한 2가지 방법이 있음.
- 각 방법은 장/단점이 있고, notification의 개수와 타입에 따라서 달라짐.

1. 등록 시점에 단말 언어를 알아내서 단말 언어를 서버로 전송. 서버가 이 언어로 APNs에 요청.

2. payload에 키만 전송하고 단말에서 해당 언어로 변환.

   - 이 경우 title, body key 대신에 title-loc-args / loc-key / loc-args 등을 사용

   ```json
   {
       "aps": {
           "alert": {
               "title-loc-key": "FOOD_ORDERED", 
               "loc-key": "FOOD_PICKUP_TIME",
               "loc-args": ["2018-05-02T19:32:41Z"]
           }
       }
   }
   ```

   - 이러한 notification을 받게 되면, `Localizable.strings`에서 자동으로 알맞은 언어로 번역해서 전달.
   - loc-args은 loc-key에서 사용하는 매개변수 값.



#### Grouping notifications

- iOS12 부터 `thread_identifier`를 사용해서 같은 identifier끼리 그룹화 할 수 있음. 
- 다른 알림과 구별되는 unique한 key를 사용해야 함. (ex. database primary key, UUID)



#### Badge

- badge key를 이용해서 badge number를 지정해 주면 됨. 

- badge를 없애고 싶으면 0으로 세팅하면 됨.

- badge number은 더하거나 뺄 수 없음. 그냥 절대적인 숫자만 가능

- 서버에게 보여주고 싶은 number를 보내줘야 함. 

  ```json
  {
    "aps": { 
      "alert": { 
          "title": "Your food is done.",
          "body": "Be careful, it's really hot!"
      },
      "badge": 12
    }
  }
  ```



#### Sound

- sound는 일반적으로는 default를 사용. 그럼 standard alert sound를 사용함.
- app main bundle에 재생하고 싶은 sound file를 저장하고 그걸 사용해도 됨. 
- sound는 30초 이하. 30초 넘으면 default sound 사용

##### Critical alert sounds

- 재난문자 처럼 critical alert을 보낼 수 있음

  ```json
  {
    "aps": { 
      "alert": { 
          "title": "Your food is done.",
          "body": "Be careful, it's really hot!"
      },
      "badge": 12,
      "sound": {
        "critial": 1, // 1이면 critical 
        "name": "filename.caf",
        "volume": 0.75 // 0.0(silent) ~ 1.0(full volume)
      }
    }
  }
  ```


### Your Custom data

- 이외에도 aps key를 자유롭게 사용하면 됨. ex. coordinate(coords)

- outside of "aps" key

  ```json
  {
    "aps": { 
      "alert": { 
        "title": "Save The Princess!"
      }
    },
    "coords": {
      "latitude": 37.33182, 
      "longitude": -122.03118
    }
  }
  ```



### Collapsing notifications

- payload는 서버가 APNs에 보내는 것들 중에 하나일 뿐이다. 
- unique device token외에도 추가적인 HTTP header를 보낼 수 있다.
- **apns-collapse-id** 
- 새로운 알림으로 이전의 알림이 더 이상 필요가 없어지면, 여러개의 알림을 새로운 알림 하나로 대체하는 기능 추가.
- apns-collapse-id의 value가 같은 경우에 이전의 알림을 삭제.(unique value 여야 함) 



### Key points

- alert key로 dictionary 사용
- localization 이슈: server-side vs. client-side
- apns-collapse-id HTTP header를 사용해서 여러개의 알림 되서 하나의 updating 알림만 남도록 할 수 있음.
- outside of aps key에서 custom data/key 사용 가능
- notification이 grouping / collapsing 중 뭐가 더 나은지 고민해보기 



참고: https://apple.co/2Ia9iUf

