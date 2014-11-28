//
//  CEMLaunchViewController.m
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 24/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMLaunchViewController.h"
#import "CEMArticle.h"
#import "CEMAd.h"
#import "CEMNewsCollectionViewController.h"

@interface CEMLaunchViewController ()

@end

@implementation CEMLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CEMSettings getChannels] == nil){
        [[CEMElMundoApi alloc] channels:@"userId" calledBy:self withSuccess:@selector(channelsDidEnd:) andFailure:@selector(channelsFailure:)];
    } else {
        [self goToChannels:[CEMSettings getChannels]];
    }

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_spinner startAnimating];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationItem.hidesBackButton = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_spinner stopAnimating];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)channelsDidEnd:(id)result
{
    NSLog(@"channelsDidEnd");

    //NSMutableArray *articles = [[NSArray arrayWithArray:(NSArray *)result] mutableCopy];
    //[articles addObjectsFromArray:articles];
    
    [CEMSettings setChannels:result];
    
    [self goToChannels:result];
}

-(void)channelsFailure:(id)result
{
    NSLog(@"channelsFailure");
}

-(void)goToChannels:(NSArray *)arrayOfChannels{
    CEMNewsCollectionViewController *articlesVC = [[CEMNewsCollectionViewController alloc] initWithTitle:@"El Mundo"
                                                                                                articles:arrayOfChannels
                                                                                              backButton:NO];
    
    [[self navigationController] pushViewController:articlesVC animated:YES];
}
/*
 CEMArticle *article1 = [CEMArticle articleWithId:@"1"
 title:@"Nueva noticia 1 super guay"
 text:@"Chanante ipsum dolor sit amet, bonico del tó quis zagal bizcoché bocachoti cabeza de viejo cuerpo de joven, gaticos magna viejuno. A tope con la maquinaria, ut ad fresquete páharo, labore soooy crossoverr con las rodillas in the guanter estoy fatal de lo mío ea freshquisimo regomello artista agazapao. Gatete ea monetes nui vivo con tu madre en un castillo enjuto mojamuto, muchachada bufonesco mamellas to sueltecico atiendee dolore ea dolore. Asquerosito piticli sed nuiiiii ojete moreno ut bajonaaa forrondosco traeros tol jamón chotera ut tunante tontaco aliqua síberet. Nostrud gañán ju-já chavalada nianoniano quis eiusmod droja no te digo ná y te lo digo tó, magna mangurrián dolore interneeeer. Dolore ut pepinoninoni minim es de traca forrondosco enim sed one more time payacho. Mangurrián ayy qué gustico no te digo ná y te lo digo tó ut tempor et exercitation minim sed eiusmod zanguango asquerosito regomello minim. Adipisicing síberet cartoniano adipisicing, zagal freshquisimo pero qué pelazo asobinao atiendee ut, et. Horcate ut super ñoño hueles avinagrado incididunt bufonesco eiusmod cobete interneeeer saepe, magna cascoporro monetes chachachá."
 url:@"http://www.elmundo.es/?cuaqea"
 creator:@"Enrique Mendoza"
 guid:@"www.1"
 categories:@[@"política", @"deporte"]
 publicationDate:[NSDate date]
 channelId:@"Internacional - El Mundo"
 textSummary:@"Chanante ipsum dolor sit amet, bonico del tó quis zagal bizcoché bocachoti cabeza de viejo cuerpo de joven, gaticos magna viejuno. A tope con la maquinaria, ut ad fresquete páharo, labore soooy crossoverr con las rodillas in the guanter estoy fatal de lo mío ea freshquisimo..."
 images:nil
 videos:nil
 commentsCount:9
 comments:nil
 sharedCount:15
 voteCount:991
 ad:nil];
 CEMArticle *article2 = [CEMArticle articleWithId:@"2"
 title:@"Premio a los vecinos ilustres"
 text:@"Chanante ipsum dolor sit amet, enjuto mojamuto, ojete calor saepe saepe veniam estoy fatal de lo mío eveniet. Gatete bonico del tó eveniet enim aliqua fresquete et asobinao chiquititantantan. Exercitation freshquisimo enim veniam labore chavalada. Cosica gambitero zagal eveniet tontaco eveniet incididunt chotera mamellas regomello. Eres un pirámidee minim magna chachachá to sueltecico droja."
 url:@"http://www.elmundo.es/?cuaqea"
 creator:@"Enrique Mendoza"
 guid:@"www.1"
 categories:@[@"política", @"deporte"]
 publicationDate:[NSDate date]
 channelId:@"Internacional - El Mundo"
 textSummary:@"El Consistorio distinguirá a los premiados con una calle o plaza pública Destacado..."
 images:nil
 videos:nil
 commentsCount:3
 comments:nil
 sharedCount:7
 voteCount:500
 ad:nil];
 
 CEMArticle *article3 = [CEMArticle articleWithId:@"3"
 title:@"Nueva noticia 1 super guay"
 text:@"Con motivo de las II Jornadas Mamací (Mamas, Matronas y Cine),  que tendrán lugar los días 28 y 29 de noviembre en los multicines Monopol, las matronas especialistas en parto natural y lactancia, Goretti Martel y Sara Barreto, responderán este jueves a partir de las 13.00 horas las dudas de los lectores de laprovincia.es en un encuentro digital.¿Se puede dar a luz por parto natural después de haber tenido una césarea? ¿Cuáles son los beneficios de un parto en casa?. ¿Cuántos meses se recomienda la lactancia materna exclusiva? Envía tus dudas a las matronas."
 url:@"http://www.elmundo.es/?cuaqea"
 creator:@"Enrique Mendoza"
 guid:@"www.1"
 categories:@[@"política", @"deporte"]
 publicationDate:[NSDate date]
 channelId:@"Internacional - El Mundo"
 textSummary:@"Chanante ipsum dolor sit amet, bonico del tó quis zagal bizcoché bocachoti cabeza de viejo cuerpo de joven, gaticos magna viejuno. A tope con la maquinaria, ut ad fresquete páharo, labore soooy crossoverr con las rodillas in the guanter estoy fatal de lo mío ea freshquisimo..."
 images:nil
 videos:nil
 commentsCount:0
 comments:nil
 sharedCount:0
 voteCount:0
 ad:nil];
 
 CEMArticle *article4 = [CEMArticle articleWithId:@"4"
 title:@"NEy ey ey"
 text:@"4Con motivo de las II Jornadas Mamací (Mamas, Matronas y Cine),  que tendrán lugar los días 28 y 29 de noviembre en los multicines Monopol, las matronas especialistas en parto natural y lactancia, Goretti Martel y Sara Barreto, responderán este jueves a partir de las 13.00 horas las dudas de los lectores de laprovincia.es en un encuentro digital.¿Se puede dar a luz por parto natural después de haber tenido una césarea? ¿Cuáles son los beneficios de un parto en casa?. ¿Cuántos meses se recomienda la lactancia materna exclusiva? Envía tus dudas a las matronas."
 url:@"http://www.elmundo.es/?cuaqea"
 creator:@"Enrique Mendoza"
 guid:@"www.1"
 categories:@[@"política", @"deporte"]
 publicationDate:[NSDate date]
 channelId:@"Internacional - El Mundo"
 textSummary:@"Chanante ipsum dolor sit amet, bonico del tó quis zagal bizcoché bocachoti cabeza de viejo cuerpo de joven, gaticos magna viejuno. A tope con la maquinaria, ut ad fresquete páharo, labore soooy crossoverr con las rodillas in the guanter estoy fatal de lo mío ea freshquisimo..."
 images:nil
 videos:nil
 commentsCount:0
 comments:nil
 sharedCount:0
 voteCount:0
 ad:nil];
 
 CEMArticle *article5 = [CEMArticle articleWithId:@"5"
 title:@"Nueva noticia 123 super guay"
 text:@"5Con motivo de las II Jornadas Mamací (Mamas, Matronas y Cine),  que tendrán lugar los días 28 y 29 de noviembre en los multicines Monopol, las matronas especialistas en parto natural y lactancia, Goretti Martel y Sara Barreto, responderán este jueves a partir de las 13.00 horas las dudas de los lectores de laprovincia.es en un encuentro digital.¿Se puede dar a luz por parto natural después de haber tenido una césarea? ¿Cuáles son los beneficios de un parto en casa?. ¿Cuántos meses se recomienda la lactancia materna exclusiva? Envía tus dudas a las matronas."
 url:@"http://www.elmundo.es/?cuaqea"
 creator:@"Enrique Mendoza"
 guid:@"www.1"
 categories:@[@"política", @"deporte"]
 publicationDate:[NSDate date]
 channelId:@"Internacional - El Mundo"
 textSummary:@"Chanante ipsum dolor sit amet, bonico del tó quis zagal bizcoché bocachoti cabeza de viejo cuerpo de joven, gaticos magna viejuno. A tope con la maquinaria, ut ad fresquete páharo, labore soooy crossoverr con las rodillas in the guanter estoy fatal de lo mío ea freshquisimo..."
 images:nil
 videos:nil
 commentsCount:0
 comments:nil
 sharedCount:0
 voteCount:0
 ad:nil];
 
 NSArray *articles = @[article1, article2, article3, article4, article5];
 */
@end
