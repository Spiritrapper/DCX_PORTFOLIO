/**
 * 
 */

// "부위1" 및 "dis_symptom" 값을 클릭한 div에서 가져와 URL로 이동
document.querySelectorAll(".symptom1").forEach(function(symptomDiv) {
    symptomDiv.addEventListener("click", function() {
        // 선택된 symptomDiv 요소에서 data-symptom 속성을 가져옵니다.
        var selectedSymptom = symptomDiv.getAttribute("data-symptom");

        // 선택된 symptomDiv의 부모 요소인 #light_div의 하위 input 요소를 찾습니다.
        var inputElement = symptomDiv.parentElement.querySelector("input");

        // input 요소에서 값을 가져옵니다.
        var selectedPart = inputElement.value;

	 // 폼 엘리먼트를 선택합니다.
        var myForm = document.getElementById("myForm1");
/*
        // 폼의 input 요소에 값을 설정합니다.
        myForm.elements["dis_part"].value = selectedPart;
        myForm.elements["dis_symptom"].value = selectedSymptom;
*/
        // 폼을 제출합니다.
        myForm.submit();

        // URL로 이동
        window.location.href = "/bigdata/disease?dis_part=" + selectedPart + "&dis_symptom=" + selectedSymptom;
    });
});


document.querySelectorAll(".symptom2").forEach(function(symptomDiv) {
    symptomDiv.addEventListener("click", function() {
        // 선택된 symptomDiv 요소에서 data-symptom 속성을 가져옵니다.
        var selectedSymptom = symptomDiv.getAttribute("data-symptom");

        // 선택된 symptomDiv의 부모 요소인 #light_div의 하위 input 요소를 찾습니다.
        var inputElement = symptomDiv.parentElement.querySelector("input");

        // input 요소에서 값을 가져옵니다.
        var selectedPart = inputElement.value;

	 // 폼 엘리먼트를 선택합니다.
        var myForm = document.getElementById("myForm2");
/*
        // 폼의 input 요소에 값을 설정합니다.
        myForm.elements["dis_part"].value = selectedPart;
        myForm.elements["dis_symptom"].value = selectedSymptom;
*/
        // 폼을 제출합니다.
        myForm.submit();

        // URL로 이동
        window.location.href = "/bigdata/disease?dis_part=" + selectedPart + "&dis_symptom=" + selectedSymptom;
    });
});

document.querySelectorAll(".symptom3").forEach(function(symptomDiv) {
    symptomDiv.addEventListener("click", function() {
        // 선택된 symptomDiv 요소에서 data-symptom 속성을 가져옵니다.
        var selectedSymptom = symptomDiv.getAttribute("data-symptom");

        // 선택된 symptomDiv의 부모 요소인 #light_div의 하위 input 요소를 찾습니다.
        var inputElement = symptomDiv.parentElement.querySelector("input");

        // input 요소에서 값을 가져옵니다.
        var selectedPart = inputElement.value;

	 // 폼 엘리먼트를 선택합니다.
        var myForm = document.getElementById("myForm3");
/*
        // 폼의 input 요소에 값을 설정합니다.
        myForm.elements["dis_part"].value = selectedPart;
        myForm.elements["dis_symptom"].value = selectedSymptom;
*/
        // 폼을 제출합니다.
        myForm.submit();

        // URL로 이동
        window.location.href = "/bigdata/disease?dis_part=" + selectedPart + "&dis_symptom=" + selectedSymptom;
    });
});

document.querySelectorAll(".symptom4").forEach(function(symptomDiv) {
    symptomDiv.addEventListener("click", function() {
        // 선택된 symptomDiv 요소에서 data-symptom 속성을 가져옵니다.
        var selectedSymptom = symptomDiv.getAttribute("data-symptom");

        // 선택된 symptomDiv의 부모 요소인 #light_div의 하위 input 요소를 찾습니다.
        var inputElement = symptomDiv.parentElement.querySelector("input");

        // input 요소에서 값을 가져옵니다.
        var selectedPart = inputElement.value;

	 // 폼 엘리먼트를 선택합니다.
        var myForm = document.getElementById("myForm4");
/*
        // 폼의 input 요소에 값을 설정합니다.
        myForm.elements["dis_part"].value = selectedPart;
        myForm.elements["dis_symptom"].value = selectedSymptom;
*/
        // 폼을 제출합니다.
        myForm.submit();

        // URL로 이동
        window.location.href = "/bigdata/disease?dis_part=" + selectedPart + "&dis_symptom=" + selectedSymptom;
    });
});

document.querySelectorAll(".symptom5").forEach(function(symptomDiv) {
    symptomDiv.addEventListener("click", function() {
        // 선택된 symptomDiv 요소에서 data-symptom 속성을 가져옵니다.
        var selectedSymptom = symptomDiv.getAttribute("data-symptom");

        // 선택된 symptomDiv의 부모 요소인 #light_div의 하위 input 요소를 찾습니다.
        var inputElement = symptomDiv.parentElement.querySelector("input");

        // input 요소에서 값을 가져옵니다.
        var selectedPart = inputElement.value;

	 // 폼 엘리먼트를 선택합니다.
        var myForm = document.getElementById("myForm5");
/*
        // 폼의 input 요소에 값을 설정합니다.
        myForm.elements["dis_part"].value = selectedPart;
        myForm.elements["dis_symptom"].value = selectedSymptom;
*/
        // 폼을 제출합니다.
        myForm.submit();

        // URL로 이동
        window.location.href = "/bigdata/disease?dis_part=" + selectedPart + "&dis_symptom=" + selectedSymptom;
    });
});

document.querySelectorAll(".symptom6").forEach(function(symptomDiv) {
    symptomDiv.addEventListener("click", function() {
        // 선택된 symptomDiv 요소에서 data-symptom 속성을 가져옵니다.
        var selectedSymptom = symptomDiv.getAttribute("data-symptom");

        // 선택된 symptomDiv의 부모 요소인 #light_div의 하위 input 요소를 찾습니다.
        var inputElement = symptomDiv.parentElement.querySelector("input");

        // input 요소에서 값을 가져옵니다.
        var selectedPart = inputElement.value;

	 // 폼 엘리먼트를 선택합니다.
        var myForm = document.getElementById("myForm6");
/*
        // 폼의 input 요소에 값을 설정합니다.
        myForm.elements["dis_part"].value = selectedPart;
        myForm.elements["dis_symptom"].value = selectedSymptom;
*/
        // 폼을 제출합니다.
        myForm.submit();

        // URL로 이동
        window.location.href = "/bigdata/disease?dis_part=" + selectedPart + "&dis_symptom=" + selectedSymptom;
    });
});

document.querySelectorAll(".symptom7").forEach(function(symptomDiv) {
    symptomDiv.addEventListener("click", function() {
        // 선택된 symptomDiv 요소에서 data-symptom 속성을 가져옵니다.
        var selectedSymptom = symptomDiv.getAttribute("data-symptom");

        // 선택된 symptomDiv의 부모 요소인 #light_div의 하위 input 요소를 찾습니다.
        var inputElement = symptomDiv.parentElement.querySelector("input");

        // input 요소에서 값을 가져옵니다.
        var selectedPart = inputElement.value;

	 // 폼 엘리먼트를 선택합니다.
        var myForm = document.getElementById("myForm7");
/*
        // 폼의 input 요소에 값을 설정합니다.
        myForm.elements["dis_part"].value = selectedPart;
        myForm.elements["dis_symptom"].value = selectedSymptom;
*/
        // 폼을 제출합니다.
        myForm.submit();

        // URL로 이동
        window.location.href = "/bigdata/disease?dis_part=" + selectedPart + "&dis_symptom=" + selectedSymptom;
    });
});


document.querySelectorAll(".symptom8").forEach(function(symptomDiv) {
    symptomDiv.addEventListener("click", function() {
        // 선택된 symptomDiv 요소에서 data-symptom 속성을 가져옵니다.
        var selectedSymptom = symptomDiv.getAttribute("data-symptom");

        // 선택된 symptomDiv의 부모 요소인 #light_div의 하위 input 요소를 찾습니다.
        var inputElement = symptomDiv.parentElement.querySelector("input");

        // input 요소에서 값을 가져옵니다.
        var selectedPart = inputElement.value;

	 // 폼 엘리먼트를 선택합니다.
        var myForm = document.getElementById("myForm8");
/*
        // 폼의 input 요소에 값을 설정합니다.
        myForm.elements["dis_part"].value = selectedPart;
        myForm.elements["dis_symptom"].value = selectedSymptom;
*/
        // 폼을 제출합니다.
        myForm.submit();

        // URL로 이동
        window.location.href = "/bigdata/disease?dis_part=" + selectedPart + "&dis_symptom=" + selectedSymptom;
    });
});