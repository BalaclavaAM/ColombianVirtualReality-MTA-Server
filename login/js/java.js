const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const login = document.getElementById('loginNow');
const creteAccount = document.getElementById('createNow');

const container = document.getElementById('container');

signUpButton.addEventListener('click', () => {
    container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
    container.classList.remove("right-panel-active");
    console.log(getSI_name())
    
});



			function tes(comand){
				var login = document.getElementById("hh").value
				var password = document.getElementById("jj").value
				mta.triggerEvent("ssj", login, password, comand)
			}
			
			function test(command){
				var login = document.getElementById("kk").value
				var password = document.getElementById("nn").value
				var email = document.getElementById("em").value
				mta.triggerEvent("cmsg", login, password, email, command)
			}
			
						function teso(cod){
				mta.triggerEvent("cm", cod)
			}
			
			
			