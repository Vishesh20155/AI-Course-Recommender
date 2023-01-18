:- dynamic suggestCourse/1.
:- dynamic courseDone/1.

% courseDone(nt).
% courseDone(ra1).
% courseDone(m1).
% courseDone(m2).
% % courseDone(m3).
% courseDone(ip).
% courseDone(dsa).
% courseDone(ap).
% courseDone(cn).
% courseDone(os).
% courseDone(sns).
% courseDone(hci).


courseByBranch(cse, [fcs, ns, ac, ai, ml, nlp, rl, cmp, ca, aag, mad]).
courseByBranch(csb, monsoon, [mlba, bip, chi, fomb]).
courseByBranch(csss, monsoon, [gmt, ff, tfw, etb, ndm, cmm, ecomm, ek]).

main:-
	write('----------------------------------------'), nl,
	write('Welcome to the Electives Advisory Portal'), nl,
	write('----------------------------------------'), nl, nl,
	
	write('Enter your branch (cse/ece/csam/csb/csss/csd): '),nl,
	read(Branch),
	nl, nl,

	write('Enter Semester type (monsoon/winter): '),nl,
	read(SemesterType), nl, nl,

	% write('Enter courses done: '), nl, read(CD), assert(courseDone(CD)), nl,

	writeln('Enter the branches other than yours in which you are interested(cse/csd/ece/csam/csb/csss). Enter stop to not add more branches'),
    addOtherDepts(OtherDepts),!,
	append([Branch], OtherDepts, DeptList),
	deptWiseCourses(SemesterType, DeptList),
	% getCourses(Branch, SemesterType),

	% write('Enter the value of X for check function: '),nl,
	% read(X), check(X),

	nl, nl, write('Your branch is: '), write(Branch), write(DeptList), nl, nl, func_for_nlp().

func_for_nlp():-
	write('Courses suggested for you are: '), findall(X, suggestCourse(X), Answer), write(Answer), nl,
	write('You are suggested to take the following courses:'), nl, printSuggestions(Answer), nl.

check(X):-X='yes', write('Y').
check(X):-X='no', write('N').

% Prints Course of 'Branch'
getCourses(Branch, SemesterType):-
	courseByBranch(Branch, SemesterType, Courses),
	nl, write('Possible Courses are: '),nl,
	write(Courses), nl.

% Add other branches in list, other than core branch.
addOtherDepts([NewDept|OtherDepts]):-
    write('Enter: '), nl,
    read(NewDept),
    dif(NewDept, stop),
    addOtherDepts(OtherDepts).

addOtherDepts([]).

% Print the courses based on selected streams in list
deptWiseCourses(_, []).
deptWiseCourses(SemesterType, [H|T]) :- getCourseSuggestion(H, SemesterType), deptWiseCourses(SemesterType, T).


% To get the suggestion of the course based on branch
getCourseSuggestion(cse, monsoon):-
	write('These are the broad fields from CSE. Enter y to if you are interested and n if you are not: '),nl,
	write('Cyber Security'), nl, read(X1), nl, securityCourses(X1),
	write('Advanced topics in core Computer Science'), nl, read(X2), nl, advCSCourse(X2),
	write('Algorithms'), nl, read(X3), nl, algoCourse(X3),
	write('Machine Learning and related fields'), nl, read(X4), nl, mlCourses(X4).

getCourseSuggestion(csb, monsoon):-
	write('Do you wish to do theory based BIO courses? (y/n)'), nl, read(X5), nl, bioTheory(X5),
	write('Do you wish to do CS & Algo oriented BIO courses? (y/n)'), nl, read(X6), nl, bioPrac(X6).

getCourseSuggestion(csss, monsoon):-
	write('Do you wish to do ECONOMICS course? (y/n)'), nl, read(X7), nl, ecoCourses(X7),
	write('Do you wish to do SOCIOLOGY courses? (y/n)'), nl, read(X8), nl, socCourse(X8),
	write('Do you wish to do PSYCHOLOGY courses? (y/n)'), nl, read(X9), nl, psyCourses(X9),
	write('Do you wish to do ENTREPRENEURSHIP courses? (y/n)'), nl, read(X10), nl, entCourses(X10).

getCourseSuggestion(csam, monsoon):-
	checkPreAdd(cmpa),
	checkPreAdd(tnt),
	checkPreAdd(sc).

getCourseSuggestion(csd, monsoon):-
	assert(suggestCourse(iag)),
	assert(suggestCourse(davp)),
	checkPreAdd(df).

getCourseSuggestion(csb, winter):-
	write('Do you wish to do BIO courses related to DATA SCIENCE? (y/n)'), nl, read(X11), nl, bioDataCourses(X11),
	write('Do you wish to do BIO related ALGORITHM courses? (y/n)'), nl, read(X12), nl, bioAlgo(X12).

getCourseSuggestion(csss, winter):-
	write('Do you wish to do ECONOMICS course? (y/n)'), nl, read(X13), nl, ecoCoursesW(X13),
	write('Do you wish to do SOCIOLOGY courses? (y/n)'), nl, read(X14), nl, socCourseW(X14),
	write('Do you wish to do PSYCHOLOGY courses? (y/n)'), nl, read(X15), nl, psyCoursesW(X15),
	write('Do you wish to do ENTREPRENEURSHIP courses? (y/n)'), nl, read(X16), nl, entCoursesW(X16).

getCourseSuggestion(csd, winter):-
	assert(suggestCourse(dis)),
	checkPreAdd(athcc),
	assert(suggestCourse(gdd)).

getCourseSuggestion(csam, winter):-
	checkPreAdd(ifa),
	checkPreAdd(si),
	checkPreAdd(coo),
	checkPreAdd(lo).

getCourseSuggestion(cse, winter):-
	write('These are the broad fields from CSE. Enter y to if you are interested and n if you are not: '),nl,
	write('Security Related Courses'), nl, read(X17), nl, securityCoursesW(X17),
	write('Networking'), nl, read(X18), nl, networkCoursesW(X18),
	write('Machine Learning and related fields'), nl, read(X19), nl, mlCoursesW(X19),
	write('Other general CSE courses'), nl, read(X20), nl, otherCseW(X20).

getCourseSuggestion(ece, winter):-
	write('Enter y for subtopics you are interested in:'), nl,
	write('Communication related courses'), nl, read(X21), nl, commW(X21),
	write('Electronics Design'), nl, read(X22), nl, elecDesW(X22).

getCourseSuggestion(ece, monsoon):-
	write('Enter y for subtopics you are interested in:'), nl,
	write('Hardware inclined courses'), nl, read(X23), nl, hardWareM(X23),
	write('Software inclined courses'), nl, read(X24), nl, softWareM(X24).


hardWareM(n):-write('').
hardWareM(y):-
	assert(suggestCourse(icf)),
	assert(suggestCourse(qmd)).

softWareM(n):-write('').
softWareM(y):-
	assert(suggestCourse(dpm)),
	checkPreAdd(dsp),
	checkPreAdd(tgi).


commW(n):-write('').
commW(y):-
	checkPreAdd(rs),
	checkPreAdd(pdcs).

elecDesW(n):-write('').
elecDesW(y):-
	assert(suggestCourse(vdf)),
	checkPreAdd(aeld).
	


securityCoursesW(n):-write('').
securityCoursesW(y):-
	assert(suggestCourse(tmc)),
	checkPreAdd(tacs),
	checkPreAdd(nssii).

networkCoursesW(n):-write('').
networkCoursesW(y):-
	checkPreAdd(wn),
	checkPreAdd(pn).

otherCseW(n):-write('').
otherCseW(y):-
	checkPreAdd(mc),
	checkPreAdd(fpp),
	checkPreAdd(gpu).

mlCoursesW(n):-write('').
mlCoursesW(y):-
	checkPreAdd(mlw),
	assert(suggestCourse(dl)),
	checkPreAnti(sml).

ecoCoursesW(n):-write('').
ecoCoursesW(y):-assert(suggestCourse(ma)).

socCourseW(n):-write('').
socCourseW(y):-assert(suggestCourse(its)), assert(suggestCourse(ast)).

psyCoursesW(n):-write('').
psyCoursesW(y):-assert(suggestCourse(sp)), assert(suggestCourse(lm)).

entCoursesW(n):-write('').
entCoursesW(y):-assert(suggestCourse(ciips)), assert(suggestCourse(ef)).


bioDataCourses(n):-write('').
bioDataCourses(y):-assert(suggestCourse(bdmh)), assert(suggestCourse(dsg)).

bioAlgo(n):-write('').
bioAlgo(y):- assert(suggestCourse(acb)), assert(suggestCourse(cmor)).

ecoCourses(n):-write('').
ecoCourses(y):-assert(suggestCourse(gmt)), assert(suggestCourse(ff)).

socCourse(n):-write('').
socCourse(y):-assert(suggestCourse(tfw)), assert(suggestCourse(etb)).

psyCourses(n):-write('').
psyCourses(y):-assert(suggestCourse(ndm)), assert(suggestCourse(cmm)).

entCourses(n):-write('').
entCourses(y):-assert(suggestCourse(ecomm)), assert(suggestCourse(ek)).

securityCourses(n):-write('').
securityCourses(y):-assert(suggestCourse(fcs)), checkPreAdd(ns), checkPreAdd(ac).

mlCourses(n):-write('').
mlCourses(y):-checkPreAdd(ai), checkPreAdd(ml), checkPreAdd(nlp), checkPreAdd(rl).

advCSCourse(n):-write('').
advCSCourse(y):-checkPreAdd(cmp), assert(suggestCourse(ca)).

algoCourse(n):-write('').
algoCourse(y):-checkPreAdd(aag), checkPreAdd(mad).


bioTheory(n):-write('').
bioTheory(y):-assert(suggestCourse(chi)), assert(suggestCourse(fomb)).

bioPrac(n):-write('').
bioPrac(y):-assert(suggestCourse(mlba)), assert(suggestCourse(bip)).


% Print the suggestions:
printSuggestions([]).
printSuggestions([H1|T1]):- printCourseInfo(H1), printSuggestions(T1).

% Printing the course Information individually for a course:
printCourseInfo(Course):-
	nl, write(Course), write(': '), courseFullName(Course, CourseFullName), write(CourseFullName), nl,
	tab(10), write('Course Instructor: Prof '), prof(Course, ProfName), write(ProfName), nl,
	tab(10), write('Credits: 4'), nl,
	tab(10), write('Course Review by Seniors: '), electiveRewiew(Course, Rev), write(Rev), nl.


% Details of the courses:

courseFullName(fcs, 'Foundations of Computer Security').
courseFullName(ns, 'Network Security').
courseFullName(ac, 'Applied Cryptography').
courseFullName(ai, 'Artificial Intelligence').
courseFullName(ml, 'Machine Learning').
courseFullName(nlp, 'Natural Language Processing').
courseFullName(rl, 'Reinforcement Learning').
courseFullName(cmp, 'Compilers').
courseFullName(ca, 'Computer Architecture').
courseFullName(aag, 'Approximation Algorithms').
courseFullName(mad, 'Modern Algorithm Design').
courseFullName(mlba, 'Machine Learning for Biomedical Applications').
courseFullName(bip, 'Biomedical Image Processing').
courseFullName(chi, 'Cheminformatics').
courseFullName(fomb, 'Foundations of Modern Biology').
courseFullName(gmt, 'Game Theory').
courseFullName(ff, 'Foundations of Finance').
courseFullName(tfw, 'Technology and the Future of Work').
courseFullName(etb, 'Enhancement Technologies and the Body').
courseFullName(ndm, 'Neuroscience of Decision Making').
courseFullName(cmm, 'Cognition of Motor Movement').
courseFullName(ecomm, 'Entrepreneurial Communication').
courseFullName(ek, 'Entrepreneurial Khichadi').
courseFullName(tnt, 'Topics in Number Theory').
courseFullName(cmpa, 'Complex Analysis').
courseFullName(sc, 'Scientific Computing').
courseFullName(iag, 'Introduction to Animation and Graphics').
courseFullName(davp, 'Digital Audio & Video Production Workflow').
courseFullName(df, 'Design Futures').
courseFullName(cmor, 'Computational Methods in Oncology Research').
courseFullName(bdmh, 'Big Data Mining in Healthcare').
courseFullName(acb, 'Algorithms in Computational Biology').
courseFullName(dsg, 'Data science in Genomics').
courseFullName(ma, 'Macroeconomics').
courseFullName(its, 'Information Technology and Society').
courseFullName(ast, 'Advanced Sociological Theory').
courseFullName(sp, 'Social Psychology').
courseFullName(lm, 'Learning and Memory').
courseFullName(ciips, 'Creativity, Innovation, and Inventive Problem Solving').
courseFullName(ef, 'Entrepreneurial Finance').
courseFullName(athcc, 'Advanced Topics in Human-Centered Computing').
courseFullName(dis, 'Design of Interactive Systems').
courseFullName(gdd, 'Game Design and Development').
courseFullName(si, 'Statistical Inference').
courseFullName(coo, 'Convex Optimization').
courseFullName(lo, 'Linear Optimization').
courseFullName(ifa, 'Introduction to Functional Analysis').
courseFullName(mlw, 'Machine Learning (Winter Semester)').
courseFullName(dl, 'Deep Learning').
courseFullName(mc, 'Mobile Computing').
courseFullName(fpp, 'Foundation of Parallel Programming').
courseFullName(gpu, 'GPU Computing').
courseFullName(wn, 'Wireless Network').
courseFullName(pn, 'Programmable Networking').
courseFullName(tmc, 'Theory of Modern cryptography').
courseFullName(tacs, 'Topics in Adaptive Cybersecurity').
courseFullName(nssii, 'Networks and System Security II').
courseFullName(sml, 'Statistical Machine Learning').
courseFullName(rs, 'Radar Systems / Antenna').
courseFullName(pdcs, 'Principles of Digital Communication Systems').
courseFullName(vdf, 'VLSI Design Flow').
courseFullName(aeld, 'Advanced Embedded Logic Design').
courseFullName(dpm, 'Data Processing and Management').
courseFullName(dsp, 'Digital Signal Processing').
courseFullName(tgi, 'Tomographic Imaging (Computerized Tomography)').
courseFullName(qmd, 'Quantum Materials and Devices').
courseFullName(icf, 'Integrated Circuit Fabrication').
% add prof


prof(fcs, 'Arun Balaji Buduru').
prof(ns, 'B N Jain').
prof(ac, 'Subhabrata Samajder').
prof(ai, 'C. Anantram').
prof(ml, 'Jainendra Shukla').
prof(nlp, 'Md. Shad Akhtar').
prof(rl, 'Sanjit Kaul').
prof(cmp, 'Piyus Kedia').
prof(ca, 'Sujay Deb').
prof(aag, 'Syamantak Das').
prof(mad, 'Diptapriyo Majumdar').
prof(mlba, 'G.P.S. Raghava').
prof(bip, 'Vibhor Kumar').
prof(chi, 'N. Arul Murugan').
prof(fomb, 'Vibhor Kumar').
prof(gmt, 'Kiriti Kanjilal').
prof(ff, 'Pankaj Vajpayee').
prof(tfw, 'Gayatri Nair').
prof(etb, 'Paro Mishra').
prof(ndm, 'Mrinmoy Chakrabarty').
prof(cmm, 'Sonia Baloni Ray').
prof(ecomm, 'Payel Mukherjee').
prof(ek, 'Anupam Saronwala').
prof(tnt, 'Anuradha Sharma').
prof(cmpa, 'Ashish Kumar Pandey').
prof(sc, 'Kaushik Kalyanaraman').
prof(iag, 'Anoop Ratn').
prof(davp, 'Aman Samuel').
prof(df, 'Grace Eden').
prof(cmor, 'Debarka Sen Gupta').
prof(bdmh, 'G P S Raghava').
prof(dsg, 'Vibhor Kumar').
prof(acb, 'Arul Murugan').
prof(ma, 'Kiriti Kanjilal').
prof(its, 'Amrit Srinivasan').
prof(ast, 'Gayatri Nair').
prof(sp, 'Venkata Ratnadeep Suri').
prof(lm, 'Mrinmoy Chakrabarty').
prof(ciips, 'Anuj Grover').
prof(ef, 'Pankaj Vajpayee').
prof(athcc, 'Pushpendra Singh').
prof(dis, 'Grace Eden').
prof(gdd, 'Aman Samuel').
prof(si, 'Monika Arora').
prof(coo, 'Rakesh Chaturvedi').
prof(lo, 'Subhashree Mohapatra').
prof(ifa, 'Satish Pandey').
prof(mlw, 'Saket Anand').
prof(dl, 'Md. Shad Akhtar').
prof(mc, 'Mukulika Maity').
prof(fpp, 'Vivek Kumar').
prof(gpu, 'Ojaswa Sharma').
prof(wn, 'Arani Bhattacharya').
prof(pn, 'Rinku Shah').
prof(nssii, 'Sambuddho Chakravarty').
prof(tmc, 'Donghoon Chang').
prof(tacs, 'Arun Balaji Buduru').
prof(sml, 'A V Subramanyam').
prof(rs, 'Shobha Sundaram').
prof(pdcs, 'Anand Srivastava').
prof(vdf, 'Sneh Surabh').
prof(aeld, 'Sumit Darak').
prof(dpm, 'Pravesh Biyani').
prof(dsp, 'Manuj Mukherjee').
prof(tgi, 'Prabhat Munshi').
prof(icf, 'S S Jamuar').
prof(qmd, 'Ram Krishna Ghosh').
% Add pre req


% Adding Pre Requisites:
preReq(tnt, [nt]).
preReq(cmpa, [ra1, xyz]).
preReq(sc, [m1]).
preReq(df, [dis]).
preReq(athcc, [hci]).
preReq(si, [m2]).
preReq(lo, [m1]).
preReq(coo, [m1]).
preReq(ifa, [m1]).
preReq(mlw, [m1, m2, ip, m3]).
preReq(mc, [ip]).
preReq(fpp, [ip, dsa, ap]).
preReq(gpu, [ip]).
preReq(wn, [cn]).
preReq(pn, [dsa, os, cn]).
preReq(tacs, [fcs]).
preReq(nssii, [cn, os]).
preReq(sml, [ip, m2]).
preReq(rs, [sns]).
preReq(pdcs, [pcs]).
preReq(aeld, [eld]).
preReq(dsp, [sns]).
preReq(tgi, [m1]).
preReq(ac, [dm]).
preReq(ns, [cn]).
preReq(ai, [dm]).
preReq(ml, [m1, m2, ip, m3]).
preReq(nlp, [m1, m2, ip, ada]).
preReq(rl, [m2]).
preReq(cmp, [m1, ip, dsa, ap]).
preReq(aag, [ada]).
preReq(mad, [ada]).


% Adding the anti-requisites:
antiReq(sml, pr).

% Adding reviews for each course
% Source for Reviews: Shared Elective Review Sheet
electiveRewiew(fcs, 'Moderate Course. Surprise Quizzes. Open Book Exams').
electiveRewiew(ns, 'Reviews not available').
electiveRewiew(ac, 'Interesting but tough course. A lot of proof based mathematics involved').
electiveRewiew(ai, 'Heavy Course in terms of Assignments but solves real world problems.').
electiveRewiew(ml, 'Theory Part was lesser. Familiarity with ML required. Lectures are not sufficient.').
electiveRewiew(nlp, 'An introductory course for people who want to start NLP and related courses. The course begins by explaining basic statistical NLP concepts, then moves on to working with NLP systems using DL methods. A basic understanding of ML is good').
electiveRewiew(rl, 'Heavy course with a lot of Mathematics. Score in exams is difficult but assignments are easier.').
electiveRewiew(cmp, 'Review Not Available').
electiveRewiew(ca, 'Application based course. Learn about Gem5. Theory used in project. Lot of evaluation components.' ).
electiveRewiew(aag, 'Review Not Available').
electiveRewiew(mad, 'Review Not Available').
electiveRewiew(mlba, 'Review Not Available').
electiveRewiew(bip, 'Review Not Available').
electiveRewiew(chi, 'Review Not Available').
electiveRewiew(fomb, 'Review Not Available').
electiveRewiew(gmt, 'Introductory course. Intro to to the notations and basic ideas.').
electiveRewiew(ff, 'The course offers good knowledge about basics of finance like balance sheets, shares etc. and would help in real-life situations. It is a high-scoring, low workload course').
electiveRewiew(tfw, 'Review Not Available').
electiveRewiew(etb, 'Review Not Available').
electiveRewiew(ndm, 'Review Not Available').
electiveRewiew(cmm, 'Review Not Available').
electiveRewiew(ecomm, 'Review Not Available').
electiveRewiew(ek, 'Review Not Available').
electiveRewiew(tnt, 'Review Not Available').
electiveRewiew(cmpa, 'Nice and Accommodating professor. Certain Prerequisites for taking up course, to be discussed with sir.').
electiveRewiew(sc, 'Easier and less proof intensive Math course. Nice professor. Higher grading percentages.').
electiveRewiew(iag, 'Review Not Available').
electiveRewiew(davp, 'Review Not Available').
electiveRewiew(df, 'Review Not Available').
electiveRewiew(cmor, 'Review Not Available').
electiveRewiew(bdmh, 'Review Not Available').
electiveRewiew(acb, 'Review Not Available').
electiveRewiew(dsg, 'Review Not Available').
electiveRewiew(ma, 'Interesting couse content and deals with topics like unemployment, inflation, GDP, and government policies.').
electiveRewiew(its, 'Review Not Available').
electiveRewiew(ast, 'Review Not Available').
electiveRewiew(sp, 'Review Not Available').
electiveRewiew(lm, 'Very Light course, so difficult grading slabs.').
electiveRewiew(ciips, 'Review Not Available').
electiveRewiew(ef, 'Review Not Available').
electiveRewiew(athcc, 'Research intensive course in the domain of HCI. Lectures boring at times.').
electiveRewiew(dis, 'Core course for DES students. Interesting Project but lengthy exams.').
electiveRewiew(gdd, 'Learn game development using the unreal engine. Better to know design tools beforehand').
electiveRewiew(si, 'Content can seem a little overwhelming, since it is relatively new and wide to grasp. Difficult Marking in theoretical exams. Easy Assignments.').
electiveRewiew(coo, 'Review Not Available').
electiveRewiew(lo, 'Review Not Available').
electiveRewiew(ifa, 'Review Not Available').
electiveRewiew(mlw, 'Tough but Doable Course. Absolute Grading. Must Refer to Online resources. Lot of coding and theory as well').
electiveRewiew(dl, '600 Level course and a lot of effort is expected. Must be really interested in DL before taking the course else wont be able to cope. Must have experience in ML field').
electiveRewiew(mc, 'Covers the fundamentals of Android and some concepts of wireless networks. Lot of Android programming and Hands on. Wireless networks also taught.').
electiveRewiew(fpp, 'Review Not Available').
electiveRewiew(gpu, 'Higher workload. surprise quizzes. Lots of evaluations. Interesting assignments. Attending Lectures is must.').
electiveRewiew(wn, 'Review Not Available').
electiveRewiew(pn, 'Review Not Available').
electiveRewiew(tmc, 'Review Not Available').
electiveRewiew(tacs, 'Review Not Available').
electiveRewiew(nssii, 'Review Not Available').
electiveRewiew(sml, 'Intensive course with tougher grading.').
electiveRewiew(rs, 'Review Not Available').
electiveRewiew(pdcs, 'Difficult theory. Project related to research paper. attending classes and taking notes is recommended.').
electiveRewiew(vdf, 'High workload but great course for anyone interested in VLSI.').
electiveRewiew(aeld, 'Review Not Available').
electiveRewiew(dpm, 'Review Not Available').
electiveRewiew(dsp, 'Fundamental and easier course of ECE department.').
electiveRewiew(tgi, 'Review Not Available').
electiveRewiew(qmd, 'Review Not Available').
electiveRewiew(icf, 'Review Not Available.').


checkPreAdd(CheckForCourse):-
    preReq(CheckForCourse, X), list_length(X, P, Q), ((P=Q, assert(suggestCourse(CheckForCourse)),!); (write(''), !)).


checkPreAnti(CheckForCourse2):-
	checkPreAdd(CheckForCourse2), ((courseDone(pr), retract(suggestCourse(sml))) ; (write(''))).
	

list_length([],0,0).
list_length([H|TAIL],N,Len) :- list_length(TAIL,N1, N2), N is N1 + 1, ((courseDone(H), Len is N2+1); Len is N2).