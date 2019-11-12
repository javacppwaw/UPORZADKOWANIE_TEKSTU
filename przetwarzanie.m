%% AUTOR: Maciej Wawrzyniec
%% Program na korepetycje.

%% Uporzadkowanie tekstu.
% Uporzadkowac niechlujnie napisany plik tekstowy (usunac nadmiarowe spacje, dopsowac lub
% wyrownac tekst do dlugosci linii, poprawic sposob zapisu znakow interpunkcyjnych).
% Dane wejsciowe: plik tekstowy zawierajacy przetwarzany tekst.
% Dane wyjsciowe: plik tekstowy zawierajacy przetworzony tekst.




function przetwarzanie 

    fileInput = fopen('wejscie.txt', 'r');
    fileOutput = fopen('wyjscie2.txt', 'w');

    %fprintf('Podaj szerokosc tekstu:')

    width = 30;
    ilosc_w_wierszu = 0;


    while 1
        line = fgetl(fileInput);
        if feof(fileInput) == 1
            break;
        end
        
        len = size(line, 2);
        X = ones(len, 1);
        X_ilosc = 0;
        i = 1;
     
        while i <= len
            znak = line(i);
            i = i + 1;
            if isspace(znak) == 1
                continue;
            else
                X_ilosc = X_ilosc + 1;
                X(X_ilosc) = znak;
                break;
            end
        end
        
        while i <= len
            znak = line(i);
            i = i + 1;
            if isspace(znak) == 1
                break;
            else
                X_ilosc = X_ilosc + 1;
                X(X_ilosc) = znak;
            end
         end
         
         [X_ilosc, ilosc_w_wierszu] = zapis(X, X_ilosc, fileOutput, ilosc_w_wierszu, width);
         biale = 1
         while i <= len
            znak = line(i);
            i = i + 1;
            if biale == 1
                if isspace(znak) == 1
                    continue;
                else
                    X_ilosc = X_ilosc + 1;
                    X(X_ilosc) = znak;
                    biale = 0;
                end
            else % niebiale
                if isspace(znak) == 1
                    [X_ilosc, ilosc_w_wierszu] = zapis(X, X_ilosc, fileOutput, ilosc_w_wierszu, width);
                    biale = 1;
                else
                    X_ilosc = X_ilosc + 1;
                    X(X_ilosc) = znak;
                end
            end
        end
    end


    fclose(fileInput);
    fclose(fileOutput);
end

function [X_ilosc, ilosc_w_wierszu] = zapis(X, X_ilosc, fileOutput, ilosc_w_wierszu, width)
    interp = interpunkcja(X, X_ilosc);

    if ilosc_w_wierszu == 0
        ilosc_w_wierszu = ilosc_w_wierszu + X_ilosc;
    elseif ilosc_w_wierszu + X_ilosc + interp <= width
        if interp == 1
          fprintf(fileOutput, '%c', char(32));
        end
        ilosc_w_wierszu = ilosc_w_wierszu + X_ilosc + interp;
    else % ilosc_w_wierszu + X_ilosc > width
        fprintf(fileOutput, '%c', char(10));
        ilosc_w_wierszu = X_ilosc;
    end
    
    %ilosc_w_wierszu
    for i = 1:X_ilosc
        znak = char(X(i));
        fprintf(fileOutput, '%c', znak);
    end
    X_ilosc = 0;
end

function interp = interpunkcja(X, X_ilosc)
    interp = 0;
    for i = 1:X_ilosc
        ispunct = isstrprop(char(X(i)),'punct');
        if ispunct == 0
            interp = 1;
            break
        end
    end
end

