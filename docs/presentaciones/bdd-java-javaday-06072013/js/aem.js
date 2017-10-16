
Reveal.addEventListener( 'fragmentshown', function( event ) {
    var fragment = event.fragment;
	if(fragment.id === 'start-dubinin'){
		var imagen = document.getElementById('dubinin');
		imagen.className = 'gatoaperro';
	}
	if(fragment.id === 'show-ciclo-bdd'){
		var section = document.getElementById('ciclo-bdd');
		section.className = 'ciclo-bdd-full';
	}
} );

Reveal.addEventListener( 'fragmenthidden', function( event ) {
	var fragment = event.fragment;
	if(fragment.id === 'start-dubinin'){
		var imagen = document.getElementById('dubinin');
		imagen.className = 'perroagato';
	}
	if(fragment.id === 'show-ciclo-bdd'){
		var section = document.getElementById('ciclo-bdd');
		section.className = 'ciclo-bdd';
	}
} );
