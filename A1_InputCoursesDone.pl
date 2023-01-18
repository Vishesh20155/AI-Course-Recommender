:- dynamic courseDone/1.


runInputsProg:-
    write('Enter all the courses you have done till now. When you have added all the courses, enter stop: '), nl, inp_courses, nl, nl,
    write('Thank You for adding information about the courses you have done. Now please run the Electives Advisory Program.'), nl.

inp_courses:-
    write('Enter Course: '), nl,
    read(CD),
    dif(CD, stop),
    assert(courseDone(CD)),
    inp_courses.

inp_courses.
