#MINERAÇÃO DE TEXTOS DA LITERATURA BIOMÉDICA
#TEMA: COVID-19


#IMPORTANTO BIBLIOTECAS
library(plyr) 
library(RCurl)
library(stringr)
library(XML)
library(rJava)
library(qdap)
library(reshape)
library(reshape2)
library(tm)
library(data.table)
#FUNCAO PARA ESCACOS EM BRANCO
trim <- function(x) {
  gsub("(^[[:space:]]+|[[:space:]]+$)","",x)
}

#SELECIONANDO E LENDO ARQUIVO COM PMIDs
file = file.choose()
pmids = read.table(file)
#Convertendo o dataframe pmids para lista
pmids = pmids$V1



#TIPOS EXTRAÍDOS PELO PUBTATOR
#Gene - Entrez Gene
#Chemical - MeSH
#Disease - MeSH
#Species = Taxonomy NCBI
#Mutation
#CellLine


start_time <- Sys.time()

c_achados_cellline = 0
c_achados_disease = 0
c_achados_genes = 0
c_achados_chemical = 0
c_achados_species = 0

Lista_achados_disease = list()
Lista_achados_gene = list()
Lista_species = list()
Lista_achados_cellline = list()
Lista_achados_chemical = list()
Lista_achados_species = list()

Lista_achados_disease_id = list()
Lista_achados_gene_id = list()
Lista_species_id = list()
Lista_achados_cellline_id = list()
Lista_achados_chemical_id = list()
Lista_achados_species_id = list()

lst_pmid = list()
lst_abstract = list()
lst_abstract_original = list()
lst_size_title = list()

c_artigo = 0 


for(z in 1:length(pmids)){
  pmid = pmids[z]
  url_busca = str_c('https://www.ncbi.nlm.nih.gov/research/pubtator-api/publications/export/pubtator?pmids=',pmid,'')
  linhas = readLines(url_busca)
  cat('\n **************************')
  for(i in 1:length(linhas)){
    #TÍTULO
    if((i == 1)){ 
      linha = strsplit(linhas[i], "\\|")
      titulo = trim(linha[[1]][3])
      titulo_size =  nchar(titulo)
    }
    #TÍTULO + RESUMO
    if((i == 2)){ 
      linha = strsplit(linhas[i], "\\|")
      texto = str_c(titulo," ",trim(linha[[1]][3]))
    }
    
    linha = strsplit(linhas[i], "\\t")
    Tipo = trim(linha[[1]][5])
    
    if(!is.na(Tipo)){
      cat('\nTipo = ',Tipo)
      
      ##############################################################    
      # DISEASES   
      if(Tipo == 'Disease'){
          MeshID = unlist(strsplit(linha[[1]][6], ":"))
          MeshID = trim(MeshID[2])
          PMID = linha[[1]][1]
          pos1 = as.numeric(linha[[1]][2])
          pos2 = as.numeric(linha[[1]][3])
          termo = linha[[1]][4]
          c_achados_disease = c_achados_disease + 1
          Lista_achados_disease[c_achados_disease] = termo
          Lista_achados_disease_id[c_achados_disease] = MeshID

        ##############################################################    
        # CELL LINE
      }else if(Tipo == 'CellLine'){
          CVCL_ID = unlist(strsplit(linha[[1]][6], ":"))
          CVCL_ID = trim(CVCL_ID[2])
          PMID = linha[[1]][1]
          pos1 = as.numeric(linha[[1]][2])
          pos2 = as.numeric(linha[[1]][3])
          termo = linha[[1]][4]
          c_achados_cellline = c_achados_cellline + 1
          Lista_achados_cellline[c_achados_cellline] = termo
          Lista_achados_cellline_id[c_achados_cellline] = CVCL_ID
      
      ##############################################################    
      # Chemical
        }else if(Tipo == 'Chemical'){
            MeshID = unlist(strsplit(linha[[1]][6], ":"))
            MeshID = trim(MeshID[2])
            PMID = linha[[1]][1]
            pos1 = as.numeric(linha[[1]][2])
            pos2 = as.numeric(linha[[1]][3])
            termo = linha[[1]][4]
            c_achados_chemical = c_achados_chemical + 1
            Lista_achados_chemical[c_achados_chemical] = termo
            Lista_achados_chemical_id[c_achados_chemical] = MeshID
        
    ##############################################################    
    # Genes
      }else if(Tipo == 'Gene'){

          PMID = linha[[1]][1]
          pos1 = as.numeric(linha[[1]][2])
          pos2 = as.numeric(linha[[1]][3])
          termo = linha[[1]][4]
          HGNC_ID = linha[[1]][6]
          c_achados_genes = c_achados_genes + 1
          Lista_achados_gene[c_achados_genes] = termo
          Lista_achados_gene_id[c_achados_genes] = HGNC_ID
        
      }
    }
  }
  
  cat('\n ################################################## CONTADOR = ',z)
  c_artigo = c_artigo + 1
  lst_abstract_original[c_artigo] = texto
  lst_pmid[c_artigo] = pmid
  
  # Sys.sleep(1)
  
}


end_time <- Sys.time()
Tempo = end_time - start_time
cat('\n\n\n Tempo    = ',Tempo)

#CRIANDO DATAFRAME PARA OS ARTIGOS RECUPERADOS
lst_pmid = unlist(lst_pmid)
lst_abstract_original = unlist(lst_abstract_original)
lst_anotado = list(pmid = lst_pmid, abstract_original = lst_abstract_original)
df_anotado = as.data.frame(lst_anotado)

#EXTRAINDO FREQUÊNCIAS DE DOENÇAS 
Lista_achados_disease = unlist(Lista_achados_disease)
Lista_achados_disease = tolower(Lista_achados_disease)
#Lista_achados_disease = unique(Lista_achados_disease)
df_achados_disease = as.data.frame(table(Lista_achados_disease))
df_achados_disease = df_achados_disease[order(df_achados_disease$Freq, decreasing = TRUE),]
barplot(df_achados_disease$Freq[1:30],  col = rainbow(10), legend = df_achados_disease$Lista_achados_disease[1:30], legend.text = df_achados_disease$Lista_achados_disease[1:30])

#EXTRAINDO FREQUÊNCIAS DE DOENÇAS PELO ID
Lista_achados_disease_id = unlist(Lista_achados_disease_id)
Lista_achados_disease_id = toupper(Lista_achados_disease_id)
#Lista_achados_disease = unique(Lista_achados_disease)
df_achados_disease_id = as.data.frame(table(Lista_achados_disease_id))
df_achados_disease_id = df_achados_disease_id[order(df_achados_disease_id$Freq, decreasing = TRUE),]
df_achados_disease_id$Lista_achados_disease_id = as.character(df_achados_disease_id$Lista_achados_disease_id)
barplot(df_achados_disease_id$Freq[1:30],  col = rainbow(10), legend = df_achados_disease_id$Lista_achados_disease_id[1:30], legend.text = df_achados_disease_id$Lista_achados_disease_id[1:30])

#EXTRAINDO FREQUÊNCIAS DE QUÍMICOS 
Lista_achados_chemical = unlist(Lista_achados_chemical)
Lista_achados_chemical = tolower(Lista_achados_chemical)
#Lista_achados_disease = unique(Lista_achados_disease)
Lista_achados_chemical = as.data.frame(table(Lista_achados_chemical))
Lista_achados_chemical = Lista_achados_chemical[order(Lista_achados_chemical$Freq, decreasing = TRUE),]
barplot(Lista_achados_chemical$Freq[1:30],  col = rainbow(10), legend = Lista_achados_chemical$Lista_achados_chemical[1:30], legend.text = Lista_achados_chemical$Lista_achados_chemical[1:30])

#EXTRAINDO FREQUÊNCIAS DE GENES 
Lista_achados_gene = unlist(Lista_achados_gene)
Lista_achados_gene = toupper(Lista_achados_gene)
#Lista_achados_disease = unique(Lista_achados_disease)
Lista_achados_gene = as.data.frame(table(Lista_achados_gene))
Lista_achados_gene = Lista_achados_gene[order(Lista_achados_gene$Freq, decreasing = TRUE),]
barplot(Lista_achados_gene$Freq[1:30],  col = rainbow(10), legend = Lista_achados_gene$Lista_achados_gene[1:30], legend.text = Lista_achados_gene$Lista_achados_gene[1:30])




#######################################################################################################
#MINERAÇÃO DE ITENS FREQUENTES

#FUNÇÃO PARA ELIMINAR ABSTRACTS NA
completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}
df_anotado = completeFun(df_anotado, "abstract_original")

df_anotado$abstract_original = as.character(df_anotado$abstract_original)


#LAÇO DE REPETIÇÃO PARA A TOKENIZAÇÃO DOS RESUMOS EM FRASES, COLETANDO POSIÇÃO DA FRASE NO RESUMO, ASSIM COMO OUTRAS INFORMAÇÕES
#EXPRESSÃO REGULAR PARA ENCONTRAR FRASES DE CONCLUSÃO/RESULTADO
reg_expression_conclusion = '(results|findings|conclusion|data|taken|together|study|studies)[\\w]*(.*)(suggest|indicate|suggested|indicated|illustrated|illustrate|revealed)[\\w]*'

lst_pmids = list()
lst_start_pos = list()
lst_end_pos = list()
lst_size_title = list()
lst_title = list()
lst_conclusion = list()
lst_articles_diference_sentences = list()
lst_sentences = list()
c_articles_n_encontrados = 0
d = 0
start_pos = 0
end_pos = 0

for(i in 1:length(df_anotado$abstract_original)){
  
  pmid = df_anotado$pmid[i]
  texto_original = df_anotado$abstract_original[i]
  sentences3 = sent_detect_nlp(df_anotado$abstract_original[i])
  
  if(length(sentences3) > 0){
    
    for(x in 1:length(sentences3)){
      
      if(nchar(sentences3[x]) > 30){
      
        if(word_count(sentences3[x]) > 5){
          
          d = d + 1
          sentence_size = nchar(sentences3[x])
          
          pattern_sentence = substr(sentences3[x],1,50)
          pattern_sentence = gsub('[\\{]','-',pattern_sentence)
          pattern_sentence = gsub('[\\[]','-',pattern_sentence)
          pattern_sentence = gsub('[\\(]','\\\\(',pattern_sentence)
          pattern_sentence = gsub('[)]','\\\\)',pattern_sentence)
          
          cat("\n pattern_sentence: ",pattern_sentence)
          start_pos = unlist(gregexpr(pattern = pattern_sentence, texto_original))
          end_pos_antigo = end_pos
          end_pos = start_pos + sentence_size
          cat("\n Sentence: ",sentences3[x] )
          cat("\n Start pos: ",start_pos)
          cat("\n End pos: ",end_pos)
          if(start_pos == -1){ start_pos = end_pos_antigo + sentence_size}
          lst_start_pos[d] = start_pos
          lst_end_pos[d] = end_pos
          
          if((grepl(reg_expression_conclusion, sentences3[x])) | (x > (length(sentences3) - 3))){
            lst_conclusion[d] = "sim"
          }else{
            lst_conclusion[d] = "nao"
          }
          
          if(x == 1){
            lst_title[d] = "sim"
            lst_start_pos[d] = 1
          }else{
            lst_title[d] = "nao"
          }
          lst_pmids[d] = pmid  
          lst_sentences[d] = sentences3[x] 
          
        }
      }
    }
         

    
  }else{
    c_articles_n_encontrados = c_articles_n_encontrados + 1
    lst_articles_diference_sentences[c_articles_n_encontrados] = pmid
  }
  
}

lst_pmids = unlist(lst_pmids)
lst_orinal_sentences = unlist(lst_sentences)
lst_conclusion = unlist(lst_conclusion)
lst_title = unlist(lst_title)
lst_start_pos = unlist(lst_start_pos)
lst_end_pos = unlist(lst_end_pos)
lst_anotado = list(pmid = lst_pmids, sentence_original = lst_orinal_sentences, is_conclusion = lst_conclusion, is_title = lst_title, start_pos = lst_start_pos, end_pos = lst_end_pos)
df_anotado_nlp = as.data.frame(lst_anotado)
df_anotado_nlp$pmid = as.character(df_anotado_nlp$pmid)

#INÍCIO DO PROCESSO DE MINERAÇÃO DE REGRAS DE ASSOCIAÇÃO
df_mining = df_anotado_nlp[,1:2]
df_mining$sentence_original = as.character(df_mining$sentence_original)

#PRÉ-PROCESSAMENTO
stopwords_pubmed = c('a','about','all','almost','also','although','always',
                     'among','an','and','another','any','are','as','at','because',
                     'before','between','both','but','can','could','do','does','done','due',
                     'during','each','either','enough','especially','for','found','from',
                     'further','here','how','however','i','if','in','into','it','its','itself',
                     'just','kg','km','made','mainly','make','may','mg','might','ml','mm',
                     'most','mostly','must','nearly','neither','no','nor','obtained','often',
                     'our','overall','perhaps','pmid','quite','rather','really','regarding',
                     'several','should','show','showed','significantly','since','so','some',
                     'such','than','that','the','their','theirs','them','then','there','therefore',
                     'these','they','this','those','through','thus','to','upon','using','various',
                     'very','we','were','what','when','which','while','with','within','without',
                     'would')

stopwords_obs = c('Method','Methods','Results','Conslusion','conclusions',
                  'Discussion','of','on','or','by')

df_mining$sentence_original = tolower(df_mining$sentence_original)
df_mining$sentence_original = removeWords(df_mining$sentence_original, stopwords_pubmed)
df_mining$sentence_original = removeWords(df_mining$sentence_original, stopwords_obs)
df_mining$sentence_original = removePunctuation(df_mining$sentence_original)
df_mining$sentence_original = stripWhitespace(df_mining$sentence_original)

#REPRESENTAÇÃO DOS TEXTOS EM TRANSAÇÕES, COM ITEMSETS
my_data = ""
for(i in 1:nrow(df_mining)){
  df_mining$sentence_original[i] = paste(unlist(strsplit(df_mining$sentence_original[i], " ")), collapse = ',')
  
}
library(arules)
my_data = paste(df_mining$sentence_original, sep="\n");
write(my_data, file = "my_basket");
trans = read.transactions("my_basket", format = "basket", sep=",");
inspect(trans);


#Imagem das transações
image(trans)
#Visualizando os 20 termos (itens) mais frequentes
itemFrequencyPlot(trans, topN=40, type='absolute')
#Sumário com informações estatísticas
summary(trans)

#MINERAÇÃO DE REGRAS DE ASSOCIAÇÃO USANDO ALGORITMO APRIORI, SUPORTE 0.001 E MÍNIMO DE 2 ITENS
rules <- apriori(trans, parameter = list(supp = 0.008, conf = 0.1, minlen=1))


options(digits=2)
inspect(sort(rules[1:30], by="confidence"))
inspect(rules)

#CRIANDO UM DATAFRAME PARA ARMAZENAR AS REGRAS 
ruledf = data.frame(
  lhs = labels(lhs(rules)),
  rhs = labels(rhs(rules)), 
  rules@quality)




