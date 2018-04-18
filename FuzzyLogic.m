clc;clear all
stremosi = [{'Rendah' 'Sedang' 'Tinggi' 'Sangat Tinggi'}];
strprovokasi = [{'Sedikit' 'Sedang' 'Banyak' 'Sangat Banyak'}];
trules = [{'Tidak','Ya'   ,'Ya'   ,'Ya' };
          {'Tidak','Tidak','Tidak','Ya'};
          {'Tidak','Tidak','Ya'   ,'Ya'};
          {'Tidak','Ya'   ,'Ya'   ,'Ya'}];
inputemosi = input('Masukkan emosi     : ');
inputprovokasi = input('Masukkan provokasi : ');
if inputemosi > 100 || inputemosi < 0 || inputprovokasi > 100 || inputprovokasi < 0
    disp('Input salah')
else
    %Proses Fuzzifikasi ba,bb,x
    if (inputemosi >= 0) && (inputemosi <= 36) % rendah(0-20)
        turunE = [1 0];
        naikE = [1 1];
    elseif (inputemosi > 36) && (inputemosi <= 40) %rendah & sedang(26-30)
        turunE = [1 FungsiTurun(40,36,inputemosi)];
        naikE = [2 0];
    elseif (inputemosi > 40) && (inputemosi <= 45) %sedang(31-55)
        turunE = [1 0];
        naikE = [2 FungsiNaik(45,40,inputemosi)];
    elseif (inputemosi > 45) && (inputemosi <= 60) %sedang & tinggi(56-60)
        turunE = [2 0];
        naikE = [2 1];
    elseif (inputemosi > 60) && (inputemosi <= 65) %tinggi(61-85)
        turunE = [2 FungsiTurun(65,60,inputemosi)];
        naikE = [3 FungsiNaik(65,60,inputemosi)];
    elseif (inputemosi > 65) && (inputemosi <= 73) %tinggi & sangat tinggi(86-90)
        turunE = [3 0];
        naikE = [3 1];
    elseif (inputemosi > 73) && (inputemosi <= 90) %sangat tinggi(91-100)
        turunE = [3 FungsiTurun(90,73,inputemosi)];
        naikE = [4 FungsiNaik(90,73,inputemosi)];
    elseif (inputemosi > 90) && (inputemosi <= 100) %tinggi & sangat tinggi(86-90)
        turunE = [4 0];
        naikE = [4 1];
    end

    if (inputprovokasi >= 0) && (inputprovokasi <= 20) % sedikit(0-20)
        turunP = [1 0];
        naikP = [1 1];
    elseif (inputprovokasi > 20) && (inputprovokasi <= 25) %sedikit & sedang(21-25)
        turunP = [1 FungsiTurun(25,20,inputprovokasi)];
        naikP = [2 FungsiNaik(25,20,inputprovokasi)];
    elseif (inputprovokasi > 25) && (inputprovokasi <= 45) %sedang(26-45)
        turunP = [2 0];
        naikP = [2 1];
    elseif (inputprovokasi > 46) && (inputprovokasi <= 50) %sedang & banyak(46-50)
        turunP = [2 FungsiTurun(50,46,inputprovokasi)];
        naikP = [3 FungsiNaik(50,46,inputprovokasi)];
    elseif (inputprovokasi > 50) && (inputprovokasi <= 70) %banyak(51-70)
        turunP = [3 0];
        naikP = [3 1];
    elseif (inputprovokasi > 70) && (inputprovokasi <= 75) %banyak & sangat banyak(71-75)
        turunP = [3 FungsiTurun(75,70,inputprovokasi)];
        naikP = [4 FungsiNaik(75,70,inputprovokasi)];
    elseif (inputprovokasi > 75) && (inputprovokasi <= 100) %sangat banyak(76-100)
        turunP = [4 0];
        naikP = [4 1];
    end
    disp('Proses fuzzifikasi')
    disp('==================')
    disp('Emosi') % Ouput myu emosi
    if naikE(1,2)>0
        x = ['Myu ',stremosi{1,naikE(1,1)},' = ',num2str(naikE(1,2))];
        disp(x)
    end
    if turunE(1,2)>0
        x = ['Myu ',stremosi{1,turunE(1,1)},' = ',num2str(turunE(1,2))];
        disp(x)
    end
    disp('Provokasi') % Output myu provokasi
    if naikP(1,2)>0
        x = ['Myu ',stremosi{1,naikP(1,1)},' = ',num2str(naikP(1,2))];
        disp(x)
    end
    if turunP>0
        x = ['Myu ',stremosi{1,turunP(1,1)},' = ',num2str(turunP(1,2))];
        disp(x)
    end
    disp('Proses Inferensi')
    disp('================')
    % Assign nilai bukan nol
    if naikE(1,2)>0 && naikP(1,2)>0
        nilaiA1 = min([naikE(1,2) naikP(1,2)]);
    elseif naikE(1,2)<=0
        nilaiA1 = [naikP(1,2)];
    elseif naikP(1,2)<=0
        nilaiA1 = [naikE(1,2)];
    end
    if turunE(1,2)>0 && naikP(1,2)>0
        nilaiA2 = min([turunE(1,2) naikP(1,2)]);
    elseif turunE(1,2)<=0
        nilaiA2 = [naikP(1,2)];
    elseif naikP(1,2)<=0
        nilaiA2 = [turunE(1,2)];
    end
    if naikE(1,2)>0 && turunP(1,2)>0
        nilaiB1 = min([naikE(1,2) turunP(1,2)]);
    elseif naikE(1,2)<=0
        nilaiB1 = [turunP(1,2)];
    elseif turunP(1,2)<=0
        nilaiB1 = [naikE(1,2)];
    end
    if turunE(1,2)>0 && turunP(1,2)>0
        nilaiB2 = min([turunE(1,2) turunP(1,2)]);
    elseif turunE(1,2)<=0
        nilaiB2 = [turunP(1,2)];
    elseif turunP(1,2)<=0
        nilaiB2 = [turunE(1,2)];
    end
    % Masukkin nilai inferensi ke tabel inferensi
    inferensi = [trules(naikE(1,1),naikP(1,1)) nilaiA1(1,1)
                trules(turunE(1,1),naikP(1,1)) nilaiA2(1,1)
                trules(naikE(1,1),turunP(1,1)) nilaiB1(1,1)
                trules(turunE(1,1),turunP(1,1)) nilaiB2(1,1)];
    maks = 0;temp = [{''} 0];inc = 1;awal=0;y=0;
    % Cek nilai inferensi yang sama
    for i=1:size(inferensi,1)
        if awal==0
            temp(inc,1) = inferensi(i,1);
            temp(inc,2) = inferensi(i,2);
            awal = 1;
        else
            index = 0;
            for j=1:size(temp,1)
                if strcmp(temp(j,1),inferensi(i,1))
                    index = j;
                end
            end
            if index == 0 
                temp(inc,1) = inferensi(i,1);
                temp(inc,2) = inferensi(i,2);
            end
            for j = i:size(inferensi,1)
                if j ~= i
                    if strcmp(inferensi(i,1),inferensi(j,1))
                        if inferensi{i,2} > inferensi{j,2}
                            maks = i;
                        else
                            maks = j;
                        end
                    end
                end
            end
        end
        inc = inc + 1;
    end
    % Masukkin nilai ya dan tidak
    result = [{''} 0 0];c = 1;
    for i=1:size(temp,1)
        n = size(temp(i,1));
        if n>0
            if strcmp(temp(i,1),'Ya')
                nil = {50};
            elseif strcmp(temp(i,1),'Tidak')
                nil = {100};
            end
            result(c,1) = temp(i,1);
            result(c,2) = temp(i,2);
            result(c,3) = nil;
            c = c + 1;
        end
    end
    kali=1;tambah=0;
    % Output nilai inferensi terakhir
    for i=1:size(result,1)
        if result{i,2}>0
            x = ['Myu ',result{i,1},' = ',num2str(result{i,2})];
            disp(x)
            kali = kali + (result{1,2}*result{1,3});
            tambah = tambah + result{1,2};
        end
    end
    y = (kali/tambah);
    disp('================')
    if y >= 0 && y <= 50
        disp('Hoax = Tidak')
    else
        disp('Hoax = Ya')
    end
end