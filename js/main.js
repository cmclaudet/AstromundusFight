// ======================================================================================
//                                       TEST
// ======================================================================================

function test(){ console.log("Test Function"); }

// ======================================================================================
//                                      FUNCTIONS
// ======================================================================================
let screenshotNumber = 2;

function listener_nextScreenshot(){
    screenshotNumber++;
    if (screenshotNumber > 4){ screenshotNumber = 0; }
    specScreenshot(screenshotNumber);
}
function listener_prevScreenshot(){
    screenshotNumber--;
    if (screenshotNumber < 0){ screenshotNumber = 4; }
    specScreenshot(screenshotNumber);
}
function listener_specScreenshot(element){
    if(element.target !== element.currentTarget){
        let clickedItem = element.target.id;
        screenshotNumber = parseInt(clickedItem.substring(5));
        specScreenshot(screenshotNumber);
    }
    element.stopPropagation();
}
function specScreenshot(num){
    changeScreenshot(num);
    changeBg(num);
}
function changeScreenshot(num){
    screenshots = document.getElementsByClassName("screenshot");
    for(let i=0; i<screenshots.length; i++){ screenshots[i].style.display = "none"; }

    element = document.getElementById(`ss0${num}`);
    element.style.display = "block";
}
function changeBg(num){
    let elements = document.getElementsByClassName("ssDot");

    for (let i = 0; i < elements.length; i++){
        let element = elements[i];
        element.style.backgroundColor = "transparent";
    }

    element = document.getElementById(`ssDot0${num}`);
    element.style.backgroundColor = "white";
}

function listener_characterHover(element){
    for(let i = 0; i < characters.length; i++){ characters[i].classList.remove("character_walk"); }
    element.target.classList.add("character_walk");

    elements = document.getElementsByClassName("aboutCharacter");
    for(let i = 0; i < elements.length; i++){ elements[i].style.display = "none"; }
    if(element.target.id === "spriteCat"){ document.getElementById("aboutCat").style.display = "block"; }
    if(element.target.id === "spriteLuis"){ document.getElementById("aboutLuis").style.display = "block"; }
    if(element.target.id === "spriteLaurence"){ document.getElementById("aboutLaurence").style.display = "block"; }
    if(element.target.id === "spriteTadeja"){ document.getElementById("aboutTadeja").style.display = "block"; }

    console.log(`Hovered over ${element.target.id}`);
}
function listener_characterClick(element){
    for(let i = 0; i < characters.length; i++){
        characters[i].classList.remove("character_attack");
        characters[i].classList.remove("character_walk");
    }
    element.target.classList.add("character_attack");

    elements = document.getElementsByClassName("aboutCharacter");
    for(let i = 0; i < elements.length; i++){ elements[i].style.display = "none"; }
    if(element.target.id === "spriteCat"){ document.getElementById("aboutCat").style.display = "block"; }
    if(element.target.id === "spriteLuis"){ document.getElementById("aboutLuis").style.display = "block"; }
    if(element.target.id === "spriteLaurence"){ document.getElementById("aboutLaurence").style.display = "block"; }
    if(element.target.id === "spriteTadeja"){ document.getElementById("aboutTadeja").style.display = "block"; }

    console.log(`Clicked on ${element.target.id}`);
}
function listener_characterAnimationend(element){
    element.target.classList.remove("character_attack");
    element.target.classList.add("character_walk");

    console.log(`${element.target.id}'s animation has ended.`);
}

// ======================================================================================
//                                      LISTENERS
// ======================================================================================

let navButtonR = document.getElementsByClassName("navButtonR")[0];
navButtonR.addEventListener("click", listener_nextScreenshot, false);

let navButtonL = document.getElementsByClassName("navButtonL")[0];
navButtonL.addEventListener("click", listener_prevScreenshot, false);

let navContainer2 = document.getElementsByClassName("navContainer2")[0];
navContainer2.addEventListener("click", listener_specScreenshot, false);

let characters = document.getElementsByClassName("character");
for(let i = 0; i < characters.length; i++) {
    characters[i].addEventListener("mouseover", listener_characterHover, false);
    characters[i].addEventListener("click", listener_characterClick, false);

    characters[i].addEventListener("animationend", listener_characterAnimationend, false);
}























function placeRandomCloud(tagName){
   target = document.getElementsByTagName(tagName);
   pos = Math.random()*90 + "%"

   var img = new Image();
   img.src = "assets/cloudWhite_64.svg";
   img.className = "cloudling";
   img.alt = "10";
   img.style.top = pos

   target[0].appendChild(img);
   //console.log("Added cloud at: " + pos);
}

function removeCloud(className){
   target = document.getElementsByClassName(className)[0];
   target.parentNode.removeChild(target);

   //console.log("Removed Cloud.");
}

function cloudRate(tagName,className,limit){
   count = document.getElementsByClassName(className).length;
   if(count >= limit){
      removeCloud(className);
      count -= 1;
   }
   if(count < limit){
      placeRandomCloud(tagName)
   }

   //console.log("Cloud Count: " + count)
}

function placeGoldenCloud(tagName){
   target = document.getElementsByTagName(tagName);
   pos = Math.random()*75 + "%"

   var img = new Image();
   img.src = "assets/cloudGold_64.svg";
   img.className = "goldenCloud";
   img.alt = "10";
   img.style.top = pos

   target[0].appendChild(img);
   console.log("Added cloud at: " + pos);
}

function goldenCloudRate(tagName,className,limit){
   count = document.getElementsByClassName(className).length;
   if(count >= limit){
      removeCloud(className);
      count -= 1;
   }
   if(count < limit){
      placeGoldenCloud(tagName)
   }

   //console.log("Cloud Count: " + count)
}

// ======================================================================================
//                                      ONLOAD
// ======================================================================================

window.onload = function(){

}
