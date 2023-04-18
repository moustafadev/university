
// input: يتم تنشيط هذا الحدث عندما يقوم المستخدم بإدخال قيمة جديدة في عنصر محدد
// ، مثل حقل النص، أو عندما يقوم المستخدم بتحديث القيمة الحالية في العنصر المحدد.
// focus: يتم تنشيط هذا الحدث عندما يقوم المستخدم بتحديد
//  أو التركيز على عنصر محدد، مثل حقل النص، عنصر الزر، أو أي عنصر آخر على الصفحة.
document.addEventListener("DOMContentLoaded", () => {
    document.querySelector("#flight-from").addEventListener("input", event => {
        flight_from(event);
    });

    document.querySelector("#flight-to").addEventListener("input", event => {
        flight_to(event);
    });

    document.querySelector("#flight-from").addEventListener("focus", event => {
        flight_from(event);
    });

    document.querySelector("#flight-to").addEventListener("focus", event => {
        flight_to(event);
    });

});


function showplaces(input) {
    let box = input.parentElement.querySelector(".places_box");
    box.style.display = 'block';
}

function hideplaces(input) {
    let box = input.parentElement.querySelector(".places_box");
    setTimeout(() => {
        box.style.display = 'none';
    }, 300);
}

function selectplace(option) {
    let input = option.parentElement.parentElement.querySelector('input[type=text]');
    input.value = option.dataset.value.toUpperCase();
    input.dataset.value = option.dataset.value;
}

function flight_to(event) {
    let input = event.target;
    showplaces(input);
}

function flight_from(event) {
    let input = event.target;
    showplaces(input);
}



