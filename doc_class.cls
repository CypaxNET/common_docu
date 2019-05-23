\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{doc_class}

\ProcessOptions\relax

\LoadClass[11pt]{article}

% packages used by default
\RequirePackage{float}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage[xcdraw]{xcolor}
\RequirePackage{hhline}
\RequirePackage{xparse}
\RequirePackage{xspace}
\RequirePackage{xstring}
\RequirePackage{tabularx}
\RequirePackage{tabulary}
\RequirePackage{colortbl}
\usepackage{titlesec}
\usepackage{fp}
\usepackage{graphicx}
\usepackage{multirow}
\usepackage{makecell}
\usepackage{lastpage}
\usepackage{ifthen}
\usepackage[utf8]{inputenc}
\usepackage[official]{eurosym}
\usepackage{soul}
\usepackage{enumitem}
\usepackage{numprint}
\RequirePackage[hidelinks,unicode,colorlinks=true,urlcolor=blue,citecolor=black,linkcolor=black]{hyperref}

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


\setuldepth{a}


\npthousandsep{\,}
\npdecimalsign{.}

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
\parskip 1em


\setlist[itemize]{nosep}
\setlist[enumerate]{nosep}

\DeclareTextFontCommand{\emph}{\bfseries}

%\renewcommand{\emph}[1]{\textbf{#1}}


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
\newcolumntype{L}{>{\raggedright\arraybackslash}X}

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

\setcounter{secnumdepth}{4}

\titleformat{\paragraph}
{\normalfont\normalsize\bfseries}{\theparagraph}{1em}{}
\titlespacing*{\paragraph}
{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}


%
% Definitions of status colors
% =====================================

\definecolor{colorGrayText}{RGB}{100,100,100}
\definecolor{colorBlackText}{RGB}{0,0,0}


\definecolor{colorApproved}{RGB}{198,239,206}
\definecolor{colorProposed}{RGB}{255,235,156}
\definecolor{colorObsolete}{RGB}{242,242,242}
\definecolor{colorUnknown}{RGB}{255,199,206}
\definecolor{colorReqBlue}{RGB}{219,229,241}
\definecolor{colorReqRed}{RGB}{242,219,219}


\newcommand{\ParameterText}[1]{\textcolor{colorBlackText}{\emph{#1}}}

\newcommand{\GeneratedText}[1]{\textcolor{colorGrayText}{#1}}



% Removes the project prefix part in a full ID
% i.e. "MYPROJECT-SYSRS-4711" results in "SYSRS-04711"
% or   "MYPROJECT-SRS-GUI-4711" results in "SRS-GUI-04711"
\newcommand{\AddLeadingZeros}[1]
{%
  \StrCount{#1}{-}[\slashcount]%                         % get the number of "-"s
  \StrBehind[\slashcount]{#1}{-}[\reqnum]%               % item number is the part behind the last "-"
  \StrBefore[\slashcount]{#1}{-}[\prefix]%               % prefix is the part before the last "-"
  \prefix-{\nplpadding{5}\npthousandsep{}\numprint{\reqnum}}%  % build new ID
}%




% Prints two columns with highlighted item status
\newcommand{\ItemStatus}[1]
{%
  \ifthenelse{\equal{#1}{approved}}%
  {%
    \colorbox{colorApproved}{\textsc{#1}}%
  }%
  {%
    {\ifthenelse{\equal{#1}{proposed}}%
      {%
        \colorbox{colorProposed}{\textsc{#1}}%
      }%
      {\ifthenelse{\equal{#1}{obsolete}}%
        {%
          \colorbox{colorObsolete}{\textsc{#1}}%
        }%
        {\ifthenelse{\equal{#1}{future\space{}feature}}%
          {%
            \colorbox{colorObsolete}{\textsc{#1}}%
          }%
          {%
            \colorbox{colorUnknown}{\textsc{#1}}%
          }%
        }%
      }%
    }%
  }%
}%



% Draws a trinagle, pointing to the parent item ID
\newcommand\ItemListParent[1]
{
  \@ifundefined{r@sec:#1}
  {$\rhd$\space{}\AddLeadingZeros{#1}\newline}
  {$\rhd$\space{}\hyperref[req:#1]{\AddLeadingZeros{#1}~\nameref{sec:#1}~(chapter \ref{sec:#1} on page \pageref{sec:#1})}\newline}
}

% Splits parent IDs and and lists them
\NewDocumentCommand\ItemListParents{>{\SplitList{,}}m}
{
  \ProcessList{#1}{\ItemListParent}
}


% Prints two columns with the item parent(s)
\newcommand{\ItemParents}[1]
{
  \IfSubStr{#1}{,}
  {\textbf{Parents:} & \ItemListParents{#1}}
  {\textbf{Parents:} & $\rhd$\space{}\AddLeadingZeros{#1}}
  \\ \hline
}


% Lists an item variant.
% If a label exists in the format 'sec:<name-of-the-variant>' a reference is added.
\makeatletter%
\newcommand\ItemListVariant[1]%
{%
  \@ifundefined{r@sec:#1}%
  {\textbullet~#1\newline}%
  {\textbullet~#1\space{}\begin{small}(see\space{}chapter\space{}``\nameref{sec:#1}'')\end{small}\newline}%
}%
\makeatother%

% Splits and processes a list of applicable variants
\NewDocumentCommand\ItemListVariants{>{\SplitList{,}}m}%
{%
  \ProcessList{#1}{\ItemListVariant}%
}%

% Prints two columns with the applicable variant(s)
\newcommand{\ItemVariants}[1]%
{%
	\IfStrEq{#1}{\empty}{}{}%
  \IfSubStr{#1}{,}%
  {\ItemListVariants{#1}\vspace{-1em}}%
  {#1}%
}%


% Prints a item flag.
\newcommand\ItemListFlag[1]
{
  \ifthenelse{\equal{#1}{flag-SAFE}}
  {
    \XBox\space{}risk\space{}mitigation\space{}measure \newline
  }
  {
    \ifthenelse{\equal{#1}{flag-SW}}
    {
      \XBox\space{}realized\space{}in\space{}software\space{}\newline
    }
    {
      \ifthenelse{\equal{#1}{flag-HW}}
      {
        \XBox\space{}realized\space{}in\space{}hardware \newline
      }
      {
        \ifthenelse{\equal{#1}{flag-MECH}}
        {
          \XBox\space{}realized\space{}in\space{}mechanics \newline
        }
        {
          \ifthenelse{\equal{#1}{flag-GUI}}
          {
            \XBox\space{}related\space{}to\space{}GUI \newline
          }
          {
            #1 \newline
          }
        }
      }
    }
  }
}

% Prints a list of item flags.
\NewDocumentCommand\ItemListFlags{>{\SplitList{,}}m}
{
  \ProcessList{#1}{\ItemListFlag}
}


% Prints two columns with a list of item flags
\newcommand\ItemFlags[1]
{
  \textbf{Flags:} & \ItemListFlags{#1}
  \\ \hline
}



% Prints two columns with a comment
\newcommand{\ItemComment}[1]
{
  \textbf{Comment:} & #1 \\ \hline
}


% Lists the IDs of areferenced an item.
% If a label exists in the format 'req:<id-of-the-referenced-item>' a reference-link is added.
\makeatletter
\newcommand\ItemListReference[1]
{
  \@ifundefined{r@req:#1}
  {$\rightarrow$\space{}\AddLeadingZeros{#1}\newline}
  {\hyperref[req:#1]{\AddLeadingZeros{#1}}\newline}
}
\makeatother


% Prints two columns with a list of references to other items
\NewDocumentCommand\ItemReferences{>{\SplitList{,}}m}
{
  \textbf{References:} &
  \ProcessList{#1}{\ItemListReference}
  \\ \hline
}


\makeatletter
\def\thickhline{%
  \noalign{\ifnum0=`}\fi\hrule \@height \thickarrayrulewidth \futurelet
  \reserved@a\@xthickhline}
\def\@xthickhline{\ifx\reserved@a\thickhline
  \vskip\doublerulesep
  \vskip-\thickarrayrulewidth
  \fi
  \ifnum0=`{\fi}}
\makeatother


\newlength{\thickarrayrulewidth}
\setlength{\thickarrayrulewidth}{2\arrayrulewidth}