---
title: webcrawling
date: 2024-06-27
categories: hnv
layout: post
---

# 웹 크롤링을 종료시키는 방법 (스크롤의 한계에 도달하면 종료하기)

```python
form selenium.webdriver.common.by import By # Selenium의 By 클래스 임포트
def find_end(self):	last_height =self.driver.execute_script(’return document.body.scrollHeight’)
	#  변수에 현재 페이지의 전체 높이를 저장.
	#  self.driver.execute_script()를 사용하여 JavaScript 코드 실행
	# document. body.scrollHeight 값을 반환
	while True:
		self.drivier.execute_script(“window.scrollto(0, document.body.scrollHeight);”) #  “window.xcrolto(0, document.body.scrollHeight);”  x= 0, y= document.body.scrollHeight, 즉 수평 스크롤 위치를 0으로 이동 수직 스크롤 위치를 전체 높이( 최하단)으로 이동 -> 스크롤 최하단으로 이동 
		time.sleep(2)  # 페이지 로드를 기달리기 위한 2초 대기
		try:
			more_button = self.driver.find_element(By.XPATH, “//button[contains(text(), ‘더보기’)]”)  # XPATH를 사용하여 텍스트에“ 더보기”가 포함된 버튼을 찾는다
 #  XPATH는 XML Path Language의 약자로, XML 및 HTML 문서 내의 노드를 찾는데 사용 (<div>, <p>, <a> 등의 태그)
			more_button.click()  # 찾은 버튼 클릭
			time.sleep(2)
		except:
			pass
		new_height = self.driver.execute_script(“return document.body.scrollHeight”)
		if new_height == last_height:
			self.end_point = True
			break
		
```
나는 def scroll_down(self)를 이미 정의 했기에 스크롤 내리는 부분을 뺀다   
self.scroll_down()  클래스 내에서 함수를 쓸 때는 self를 접두어로  

원래 코드: self.src_values에 새로운 값을 할당합니다. 이 방식은 각 호출에서 self.src_values의 기존 내용을 덮어씁니다. 결과적으로, 마지막 find_src 호출 후의 값만 유지됩니다.  
수정된 코드: self.src_values.extend를 사용하여 기존 리스트에 새로 찾은 값을 추가합니다.   
이 방식은 각 호출에서 self.src_values의 기존 내용을 보존하면서 새 값을 추가합니다. 이를 통해 모든 URL에서 찾은 모든 이미지를 self.src_values에 저장할 수 있습니다.  

원래 코드
```python
last_height = self.driver.execute_script("return document.body.scrollHeight")
new_height = self.driver.execute_script("return document.body.scrollHeight")
if new_height == last_height:
    self.end_point = True
```

수정된 코드
```python
def find_end(self):
    last_height = self.driver.execute_script("return document.body.scrollHeight")
    time.sleep(2)  # 수정: 대기 시간 추가
    new_height = self.driver.execute_script("return document.body.scrollHeight")
    self.end_point = new_height == last_height  # 수정: end_point 업데이트 위치 변경
```


원래 코드: last_height와 new_height를 거의 동시에 계산합니다. 이는 두 값이 항상 동일하여 self.end_point가 항상 True가 됩니다.  

수정된 코드:  
- last_height를 먼저 계산하고, 약간의 대기 시간을 추가(time.sleep(2))하여 페이지가 스크롤된 후 새로 고침된 높이를 반영할 시간을 줍니다.
- 새로 고침된 후의 높이(new_height)를 다시 계산하여 이전 높이(last_height)와 비교합니다.
- new_height와 last_height가 동일하면 더 이상 스크롤할 내용이 없다는 것을 의미하므로 self.end_point를 True로 설정합니다.


extend는 리스트의 메서드로서 리스트에 다른 리스트의 모든 요소를 추가할 때 사용합니다. 따라서 extend 메서드를 호출하여 리스트를 확장해야 합니다.


잘못된 코드:  
self.src_values.extend = [img.get_attribute("src") for img in img_tags if keyword in img.get_attribute("alt")]


올바른 코드:  
self.src_values.extend([img.get_attribute("src") for img in img_tags if keyword in img.get_attribute("alt")]




문제점  
1. 드라이버 초기화 이전에 스크립트 실행:
    - self.driver는 None으로 초기화되어 있습니다.
    - 따라서 self.driver.execute_script("return document.body.scrollHeight")를 호출하면 self.driver가 NoneType이므로, 이를 호출할 수 없다는 오류가 발생합니다




```python
    # end 포인트를 찾기위한 함수
    def find_end(self):
        end_find =self.driver.find_elements(By.TAG_NAME, "span")
        for end in end_find:
            if end.text =='대한민국':
                self.end_point =True
                print("End of content found")
                break
```

스크롤 내리기 전이랑 내린 후랑 스크롤의 값이 같아서 크롤링이 안됨  
그냥 span에서 대한민국 찾으면 끝나는걸로 변경  



스크롤을 내린 후에도 document.body.scrollHeight가 변하지 않는 경우  
이 문제는 페이지가 동적으로 콘텐츠를 로드하지 않거나 스크롤 이벤트가 제대로 적용되지 않는 경우 발생할 수 있습니다.  
스크롤을 내리더라도 페이지가 새로운 콘텐츠를 로드하지 않는다면 높이가 변하지 않습니다.  
스크롤 내리기 전에 scroll_from_origin 값을 변경했을 때 document.body.scrollHeight가 변하는 경우  
이 문제는 페이지가 초기 로딩 후 스크롤 이벤트를 기다리는 상태이기 때문에 발생할 수 있습니다.  
페이지는 초기 높이를 다르게 계산할 수 있으며, JavaScript를 통해 스크롤 이벤트를 직접 발생시켜 높이의 변화를 유도할 수 있습니다.  
스크롤 이벤트가 적용되지 않는 이유  

스크롤 이벤트가 제대로 발생하지 않는 이유는 여러 가지가 있습니다  
1. 페이지가 스크롤 이벤트에 반응하지 않음.
2. 스크롤 이벤트가 발생하더라도 새로운 콘텐츠가 로드되지 않음.
3. 스크롤 이벤트가 페이지의 특정 부분에만 적용되어 전체 페이지의 높이가 변하지 않음.