#  Notes

1. genre in list has no return value. Json only brings genre_ids ✅
2. fijarse que pasa con los aspect ratios del rectangle cuando no cargo la imagen 
3. backbutton [  ]


# Requisitos
### Funcionalidades esperadas:
- Pantalla principal (listado).  ✅
- Vista del detalle de acuerdo al diseño con animación en el scroll. 
- Obtener el género desde la API para mostrarlo en cada ítem.  ✅

### Funcionalidades adicionales:
- Suscribirse a una serie (localmente).
- Implementar search para hacer el home dinámico. 
- Paginación. [  ]

### Bonus    
- Diseño Detalle: Sería ideal que utilices alguna librería que te permita obtener el color principal de una imagen para poder incluír una vista con cierta transparencia. [  ]

@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

var btnBack : some View { Button(action: {
    self.presentationMode.wrappedValue.dismiss()
}) {
    HStack {
        Image("BackButton")
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
        
    }
}
}

.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
