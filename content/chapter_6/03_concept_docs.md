
## Concept Documents 


Identifying the concepts are vital during the development. Bad concept understanding ll evolve into bad  architecture and toxic development. 

Concepts can be anything.  A concept is a meta name which can be anything related to the development. It can be a essential requirement, a payment verification module or unique architecture for the product in interest. 
Concept documentations answer what needs to be done in a higher level and perfect way to do modularized development practice. 


### concepts.md

This document lists all concepts using root project documentations. (project_description.md, philosophy.md,  known_requirements.md)
 To be not overbloated we ask AI to create it using key technical concepts only. 

### concepts_clarifications folder 

We ask AI to create clarifications for each concept listed in concepts.md file. 
This is folder will contain aroud 10 different documentation. Explaining each concept. 
And as a human in the loop we get to read them and have full understanding of AI's mind. 

And each concept documentation answer these questions: 
    - clear short explanation what it is and why it matters
    - How this concept helps the overall project
    - How this concept limits the overall project
    - What kind of information this concept needs as input
    - What kind of process this concept should use
    - What kind of information this concept outputs or relays
    - explain the good expected outcome of realizing this concept
    - explain the bad unwanted outcome of realizing this concept

Which inspect the concept from multiple point of views and doesnt allow anything to be missed. 



### simplified_concepts.md

When we start developing something new usually we start with prototyping and then continues enhancements and feature additions turn protoype into a MVP.  there is a high chance when you read all 
these full scope concepts in concepts.md  you feel overwhelmed and it will be same for ai too. Our job as a human in the loop is to  make AI do the work in a modular gradual controllable increments.  

AI wont do that by itself. Even tho it is possible to ask AI to implement a prototype version with less features is possible you will notice that AI's simplification intuition is not well finetuned and must be checked by human. 

This is why we are asking AI to create this documentation for us (hiling). So we can hil it.. 

During this stage we ask ai to

  - do not oversimplify the concept to the point underlying architecture is oversimplified and does not support the original concept
  - if a concept has a support for multi subconcept, do not binarize it but diminish the number of supported subconcepts by priotizing the most important ones. 


### simplified_concepts folder 

Same as concepts_clarifications folder. 
We ask AI to create clarifications for each concept listed in simplified_concepts.md file. Explaining each concept. 
And as a human in the loop we get to read them and have full understanding of AI's mind. 

And each concept documentation answer these questions: 
    - clear short explanation what it is and why it matters
    - How this concept helps the overall project
    - How this concept limits the overall project
    - What kind of information this concept needs as input
    - What kind of process this concept should use
    - What kind of information this concept outputs or relays
    - explain the good expected outcome of realizing this concept
    - explain the bad unwanted outcome of realizing this concept





Existance of simplified_concepts.md with concepts.md together in the code base is vital.  These 2 devdocs provide the expansion scope to the ai and when new middle-concepts are introduced AI can arange them in such way that they are suitable for current and future scoppes. 

