if GetLocale() ~= "ptBR" then
    return
end

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

l10n.questLookup["ptBR"] = loadstring([[return {
[91723] = {"Instrumentos delicados", {"Mate 8 Geomantes Kobolds na Mina de Jaspe e volte a falar com Hamish Montavarga na Torre de Azora."}},
[91725] = {"Suprimentos de encantamento roubados", {"Colete 5 Suprimentos de Encantamento Roubados em acampamentos de gnolls nos entornos do Lago do Monumento e devolva-os a Blixie Fitzpisca perto da Torre de Azora."}},
[91741] = {"Livro mordiscado", {"Devolva o livro ao Irmão Paxeco."}},
[91743] = {"Fome de conhecimento", {"Recupere 8 Livros Roubados dos kobolds no Vale de Vila Norte e devolva-os para o Irmão Paxeco."}},
[91745] = {"Consultoria em mineração", {"Fale com Kelsey Fargo na entrada da Mina da Serra do Eco, no Vale de Vila Norte."}},
[91752] = {"Livro com figura também é leitura", {"Recupere um Saco de Livros com \"Ilustrações\" de Narf Descobrilho. Leve o saco para o Major Belmonte no interior da Abadia de Vila Norte."}},
[91753] = {"Uma aula encantadora", {"Kitta Ventígnea na Torre de Azora quer que você colete 3 Resíduos Luminosos.","","Você pode obter Resíduos Luminosos desencantando Efígies de Cera Rústicas deixadas por Geomantes Kobolds."}},
[91758] = {"Siga aquele kobold!", {"Fale com Tordrin Rigilâmina perto do estábulo atrás da Abadia de Vila Norte."}},
[91772] = {"Silêncio! Área de caça a kobolds", {"Siga os rastros do kobold e apresente-se ao Delegado Durão em Vila d'Ouro com as suas descobertas e o Kit de Rastreamento de Kobolds."}},
[91775] = {"Devolução de livros", {"Encontre 6 Livros Perdidos e \"Diversão com Elementais\" e devolva-os ao Delegado Durão."}},
[92124] = {"Inventário de livros", {"Fale com Daniel, o assistente do Irmão Paxeco, na biblioteca."}},
[92401] = {"Pedido desesperado", {"Investigue o desaparecimento de Edward Tececórdio nas Ruínas de Lordaeron."}},
[92515] = {"O gargalo das garraltivas", {"Colete 10 Pelagens de Garraltiva de Garraltivas no Planalto de Shen'dar."}},
[92516] = {"Hipogrifos hostis", {"Mate 8 Jovens Hipogrifos, 6 Protetores Hipogrifos e uma Matriarca Hipogrifo no Planalto de Shen'dar."}},
[92517] = {"O elemento criminoso", {"Elimine 10 Bandidos do Planalto e o líder deles, Bennic \"Malevento\", no Planalto de Shen'dar."}},
[92553] = {"Reabastecendo a despensa", {"Colete 3 Ovos Pequenos e 8 Carnes de Moa de criaturas que vivem no Planalto de Shen'dar."}},
[93318] = {"PROCURA-SE: Vulgara, a Insaciável", {"Elimine Vulgara, a Insaciável, no Planalto de Shen'dar e leve a cabeça dela a Danarii Bramivéu."}},
[93319] = {"Pedras eólicas roubadas", {"Colete 10 Pedras Eólicas Roubadas dos Bandidos do Planalto no Planalto de Shen'dar."}},
[93951] = {"Leve beleza", {"Colete 8 Plumas de Hipogrifo no Planalto de Shen'dar."}},
[94411] = {"Magos metidos", {"Mate 6 Aprendizes da Alta Ordem no Planalto de Shen'dar."}},
[94435] = {"Uma lição de divindade", {"Fale novamente com Danitha Morr na Bastilha de Bandarion."}},
[95065] = {"Hora da pesca", {"Leve 1 Miçanga Brilhosa e 3 Reptantes para Gilberto Cinéreo no porto em Ventobravo."}},
[96390] = {"Cortando o mal pela raiz", {"Mate 10 Espiões Ferro Negro em Dun Morogh."}},
[96393] = {"Incursão à Antiga Altaforja", {"Adentre o Salão dos Thanes abaixo da Antiga Altaforja e corte a cabeça de Durgen Martelúgubre."}},
[96394] = {"Os mortos inquietos", {"Mate 15 Aparições Enfurecidas, 10 Almas Atormentadas e dê descanso ao espírito de Sidermar."}},
[96395] = {"Uma mágoa ancestral", {"Dê descanso ao espírito de Faldrim Sidermar e depois fale novamente com a Atendente Fantasmagórica no Salão dos Thanes."}},
[96403] = {"Heranças importantes", {"Colete 8 Heranças Enânicas no Salão dos Thanes."}},
[97894] = {"Negócios em Auberdine", {"Veja como está Gorbold Manácero em Auberdine, na Costa Negra.","","Borgus mencionou um barco no cais mais ao sul do Porto de Ventobravo que pode levar você até lá."}},
[97963] = {"Introdução ao acampamento: Alquimia", {"Fale com Nyassa Estiágil na Aldeia de Shen'dar para aprender a criar um item de acampamento para a sua profissão quando demonstrar proficiência nessa perícia."}},
[97968] = {"Introdução ao acampamento: Herborismo", {"Fale com Syriel Serenoite em Valanaar para aprender a criar um item de acampamento para a sua profissão quando demonstrar proficiência nessa perícia."}},
[98423] = {"O Tratado de Entendimento", {"Entregue o Tratado de Entendimento para Magni Barbabronze em Altaforja."}},
}]])
