\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{doc_class}

\ProcessOptions\relax

\LoadClass[11pt]{article}

% packages used by default
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}
\RequirePackage[hidelinks,unicode,colorlinks=true,urlcolor=blue,citecolor=black,linkcolor=black]{hyperref}
\usepackage{graphicx}
\usepackage{multirow}
\usepackage{makecell}
\usepackage{lastpage}
\usepackage{ifthen}

% options handling

% select arabic numbers for pageslts automatically because it
% sometimes seems to fail autodetecting the right numbering scheme
% moreover check if draft version is disabled or not
\AtBeginDocument{%
	\pagenumbering{arabic}%
	\maketitle%
	\pagestyle{doc_general}	
	\tableofcontents
	\newpage
}

\geometry{a4paper, %
				includeheadfoot, %
				left=13mm,%
				right=11mm,%
				top=10mm,%
				bottom=10mm,%
				head=15mm, %
				foot=10mm, %
				headsep=20mm,
				footskip=10mm}

% disable floats by default in order to not confuse Word users
\renewcommand*{\fps@figure}{!ht}
\renewcommand*{\fps@table}{!ht}

% setup default fonts
\renewcommand*\sfdefault{phv}	% Helvetica for sans serif family
% use sans serif font by default
\renewcommand{\familydefault}{\sfdefault}


% no ident for new paragraphs
\parindent 0pt
%the vertical space between new paragraphs
\parskip 10pt

\newcommand{\DocClassVersion}{1.0}

% commands for project management
\def\project#1{\gdef\@project{#1}}
\def\@project{\@latex@warning@no@line{No \noexpand\project given}}

\def\projectsub#1{\gdef\@projectsub{#1}}
\def\@projectsub{\empty}

\def\projectversion#1{\gdef\@projectversion{#1}}
\def\@projectversion{\@latex@warning@no@line{No \noexpand\projectversion given}}

\def\doctitle#1{\gdef\@doctitle{#1}}
\def\@doctitle{\@latex@warning@no@line{No \noexpand\doctitle given}}

\title{\@doctitle}


% document title page
\renewcommand{\maketitle}{
% prevents the title next paragraph to be positioned directly under the headline
\vspace*{0pt}

\begin{center}
	\LARGE{\@project} \\
	\Huge\textbf{--~\@title~--}\\
	\LARGE{\@projectsub}
\end{center}	

\vfill %shall be at bottom of page!

\def\arraystretch{1.3}%	1 is the default
\begin{tabularx}{\textwidth}{lX}
	\textbf{Project:}          & \@project        \\
	\textbf{Document version:} & \@projectversion \\
	\textbf{Document date:}    & \@date           \\
	\textbf{Author(s):}        & \@author         \\
\end{tabularx}
\vspace{20mm}
\newpage
}

\newcolumntype{C}{>{\centering\arraybackslash}l}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}

\fancypagestyle{doc_general}{
		% setup header bar with logo
		\fancyhf{} % clear all header and footer fields
		\renewcommand{\headrule}{}
		\renewcommand{\footrule}{}
		\fancyhead[C]{
			{
				\bgroup
					\renewcommand{\arraystretch}{1.3}
					\begin{tabularx}{\textwidth}{XCR}
						{\@project} & {\shortstack{\large\centering\arraybackslash\textbf{\@doctitle}}} & {\@projectsub} \\
						\hline
					\end{tabularx}
				\egroup
			}
		}
		\fancyfoot[L]{
			{\footnotesize
				\bgroup
					\def\arraystretch{1.3}%	1 is the default
					\scriptsize
					\begin{tabularx}{\textwidth}{llXr}
						\hline
						Document version:~\@projectversion & Date:~\@date & Document class version:~\DocClassVersion & {Page~\thepage~/~\pageref{LastPage}} \\
					\end{tabularx}
				\egroup
			}
		}
}

