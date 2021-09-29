# Iraq Perception Study
# logic model, DAGs

library(DiagrammeR)

# aware of USAID ----

## aware 1 ----

grViz("
      digraph{

      graph[layout=dot]
      rankdir=BT
      fontcolor='yellow'

      node[shape=box, color='thistle1', style='filled',fontsize=16, alpha=.2]
      H[label='Government\nperformance', fontcolor='Maroon']
      A[label='Activities\nin community', fontcolor='Maroon']
      B[label='Security\nenvironment', fontcolor='Maroon']
      C[label='Urban/Rural\nlocality', fontcolor='Maroon']
      D[label='Socioeconomic\nstatus', fontcolor='Maroon']
      #E[label='Education', fontcolor='Maroon']
      #F[label='Income/Wealth', fontcolor='Maroon']
      G[label='Sex', fontcolor='Maroon']



      node[shape=box, color='lightblue1', style='filled', fontsize=16]
      M[label='Aware of USAID', fontcolor='MidnightBlue']

      edge[penwidth=1.5, color='DimGray']
      {A B C D H} -> M
      #{E F} -> D
      G -> M
      }
      ")

## aware 2 ----

grViz("
      digraph{

      graph[layout=dot]
      rankdir=BT
      fontcolor='yellow'

      node[shape=box, color='thistle1', style='filled',fontsize=16, alpha=.2]
      H[label='Government\nperformance', fontcolor='Maroon']
      A[label='Activities\n in activity', fontcolor='Maroon']
      G[label='Sex', fontcolor='Maroon']
      B[label='Security\nenvironment', fontcolor='Maroon']
      C[label='Urban/Rural\nlocality', fontcolor='Maroon']
      D[label='Socioeconomic\nstatus', fontcolor='Maroon']
      E[label='Education', fontcolor='Maroon']
      F[label='Income/Wealth', fontcolor='Maroon']




      node[shape=box, color='lightblue1', style='filled', fontsize=18]
      M[label='\nAware of USAID\n ', fontcolor='MidnightBlue']

      edge[penwidth=1.5, color='DimGray']
      {A D C H} -> M
      {E F C} -> D
      G -> M
      B -> {M D}
      }
      ")


## aware 3 ----

grViz("
      digraph{

      graph[layout=dot]
      rankdir=BT
      fontcolor='yellow'

      node[shape=box, color='thistle1', style='filled',fontsize=16, alpha=.2]
      A[label='Government\nperformance', fontcolor='Maroon']
      B[label='USAID / other\ndonor activity', fontcolor='Maroon']
      F[label='Socioeconomic\nstatus', fontcolor='Maroon']
      C[label='Sex', fontcolor='Maroon']
      D[label='Urban/Rural\nlocality', fontcolor='Maroon']
      E[label='Security\nenvironment', fontcolor='Maroon']
      G[label='Education', fontcolor='Maroon']
      H[label='Income/Wealth', fontcolor='Maroon']
      I[label='Corruption', fontcolor='Maroon']
      J[label='Service\ndelivery', fontcolor='Maroon']


      node[shape=box, color='lightblue1', style='filled', fontsize=18]
      M[label='\nAware of USAID\n ', fontcolor='MidnightBlue']

      edge[penwidth=1.5, color='DimGray']
      {A B C D F} -> M
      {G H} -> F
      E -> {A B F}
      {I J} -> A
      #B -> A
      }
      ")

## aware 4 ----

grViz("
      digraph{

      graph[layout=dot]
      rankdir=BT
      fontcolor='yellow'

      node[shape=box, color='thistle1', style='filled',fontsize=16, alpha=.2]
      F[label='Socioeconomic\nstatus', fontcolor='Maroon']
      B[label='USAID / other\ndonor activity', fontcolor='Maroon']
      A[label='Government\nperformance', fontcolor='Maroon']
      C[label='Sex', fontcolor='Maroon']
      D[label='Urban/Rural\nlocality', fontcolor='Maroon']
      E[label='Security\nenvironment', fontcolor='Maroon']
      G[label='Education', fontcolor='Maroon']
      H[label='Income/Wealth', fontcolor='Maroon']
      I[label='Corruption', fontcolor='Maroon']
      J[label='Service\ndelivery', fontcolor='Maroon']


      node[shape=box, color='lightblue1', style='filled', fontsize=18]
      M[label='\nAware of USAID\n ', fontcolor='MidnightBlue']

      edge[penwidth=1.5, color='DimGray']
      {A B C D F} -> M
      {G H} -> F
      E -> {I J B F}
      {I J} -> A
      B -> A
      }
      ")








# perception of USAID
grViz("
      digraph{

      graph[layout=dot]
      rankdir=BT
      fontcolor='yellow'

      node[shape=box, color='MistyRose', style='filled',fontsize=16, alpha=.2]
      A[label='\nUSAID activities\n\n', fontcolor='Maroon']
      B[label='USAID media\nmessaging', fontcolor='Maroon']
      C[label='USAID\nbranding', fontcolor='Maroon']
      D[label='Unique info\nabout USAID', fontcolor='Maroon']
      E[label='Government\nactivities', fontcolor='Maroon']
      F[label='Other donor\nactivities', fontcolor='Maroon']

      node[shape=box, color='lightblue1', style='filled', fontsize=16]
      G[label='USAID perception', fontcolor='MidnightBlue']
      H[label='GoI perception', fontcolor='MidnightBlue']

      edge[penwidth=1.5, color='darkblue']
      {E F A} -> H [color='DimGray']
      {B C D A} -> G [color='DimGray']
      #H -> G [color='DimGray']
      #G -> H [color='DimGray']
      H -> G [ color='DimGray']
      }
      ")



# perception of USAID ----

grViz("
      digraph{

      graph[layout=dot]
      rankdir=BT
      fontcolor='yellow'

      # outcomes
      node[shape=box, color='lightblue1', style='filled', fontsize=18]

      A[label='\nUSAID perception\n ', fontcolor='MidnightBlue']
      B[label='GoI\nperception', fontcolor='MidnightBlue']


      node[shape=box, color='khaki', style='filled',fontsize=16, alpha=.2]

      # direct determinants

      D[label='USAID media\nmessaging', fontcolor='Maroon']
      E[label='Unique info\nabout USAID', fontcolor='Maroon']
      C[label='\nUSAID activities\n\n', fontcolor='Maroon']

      node[shape=box, color='thistle1', style='filled',fontsize=16, alpha=.2]

      # covariates

      F[label='Other donor\nactivity', fontcolor='Maroon']
      G[label='Sex', fontcolor='Maroon']
      H[label='Urban/Rural\nlocality', fontcolor='Maroon']
      I[label='Security\nenvironment', fontcolor='Maroon']
      J[label='Individual\ncharacteristics', fontcolor='Maroon']
      K[label='Education', fontcolor='Maroon']
      L[label='Income/Wealth', fontcolor='Maroon']
      M[label='Corruption', fontcolor='Maroon']
      N[label='Service\ndelivery', fontcolor='Maroon']

      edge[penwidth=1.5, color='DimGray']

      B -> A
      {C D E J} -> A
      {C F J M N} -> B
      {G H K L} -> J
      I -> {C M N F}
      }
      ")


# logic model (media consumption) -------------------------------------------------------------
#what characteristics would drive someone to more media consumption


grViz("
      digraph{

      graph[layout=dot]
      rankdir=BT
      fontcolor='yellow'

      node[shape=box, color='MistyRose', style='filled',fontsize=16, alpha=.2]
      A[label='Urban areas', fontcolor='Maroon']
      B[label='Socio-economic\nstatus', fontcolor='Maroon']

      node[shape=box, color='lightblue1', style='filled', fontsize=16]
      G[label='Media messaging', fontcolor='MidnightBlue']

      edge[penwidth=1.5, color='darkblue']
      {A B} -> G [color='DimGray']
      #H -> G [color='DimGray']
      #G -> H [color='DimGray']
      }
      ")


