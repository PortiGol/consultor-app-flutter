<?php

namespace App\Services;

use Symfony\Component\DomCrawler\Crawler as DomCrawler;
use GuzzleHttp\Client;
use Illuminate\Support\Facades\Log;

class ConsultorService
{ // jare es pero funciona, dps voy a cambiar todo esto.....
    public function getConsultorData($username, $password)
    {
        $loginUrl = 'http://servicios.fpune.edu.py:82/consultor/index.php';
        $data = [];

        $client = new Client(['cookies' => true]);
        $response = $client->post($loginUrl, [
            'form_params' => [
                'usuario' => $username,
                'clave' => $password,
            ],
        ]);

        if ($response->getStatusCode() === 200) {
            $htmlContent = (string) $response->getBody();
            Log::info("HTML Content: " . $htmlContent);

            $crawler = new DomCrawler($htmlContent);

            // Extrae el nombre del usuario
            $name = $crawler->filter('div.col-sm-7 h3')->text();
            $data['name'] = trim($name);
            Log::info("Extracted Name: " . $data['name']);

            // Busca la tabla específica basándose en el título de la sección... en este caso el panel de inscripciones
            $crawler->filter('.panel-primary')->each(function ($panel) use (&$data) {
                // Verifica si el título de la sección es "INSCRIPCIONES Y ASISTENCIAS"
                if ($panel->filter('.panel-title')->text() === 'INSCRIPCIONES Y ASISTENCIAS') {
                    $data['inscripciones'] = [];
                    
                    // Itera sobre cada fila de la tabla
                    $panel->filter('.table-responsive table tr')->each(function ($tr, $i) use (&$data) {
                        // Ignora la primera fila que contiene los encabezados de la tabla
                        if ($i == 0) return;

                        $row = [];
                        $tr->filter('td')->each(function ($td, $j) use (&$row) {
                            // Obtén el texto de cada columna y almacénalo en $row
                            switch ($j) {
                                case 0:
                                    $row['materia'] = trim($td->text());
                                    break;
                                case 1:
                                    $row['fecha_inscripcion'] = trim($td->text());
                                    break;
                                case 2:
                                    $row['validez'] = trim($td->text());
                                    break;
                                case 3:
                                    $row['grupo'] = trim($td->text());
                                    break;
                                case 4:
                                    $row['porcentaje_asistencia'] = trim($td->text());
                                    break;
                            }
                        });


                        // Añade la fila al array de inscripciones
                        $data['inscripciones'][] = $row;
                    });
                }
            });
            $crawler->filter('.panel-primary')->each(function ($panel) use (&$data) {
                // Verifica si el título de la sección es "PAGOS"
                if ($panel->filter('.panel-title')->text() === 'ULTIMOS PAGOS EFECTUADOS') {
                    $data['pagos efectuados'] = [];
                    
                    // Itera sobre cada fila de la tabla
                    $panel->filter('.table-responsive table tr')->each(function ($tr, $i) use (&$data) {
                        // Ignora la primera fila que contiene los encabezados de la tabla
                        if ($i == 0) return;

                        $row = [];
                        $tr->filter('td')->each(function ($td, $j) use (&$row) {
                            // Obtén el texto de cada columna y almacénalo en $row
                            switch ($j) {
                                case 0:
                                    $row['Arancel'] = trim($td->text());
                                    break;
                                case 1:
                                    $row['Vencimiento'] = trim($td->text());
                                    break;
                                case 2:
                                    $row['Fecha_pago'] = trim($td->text());
                                    break;
                                case 3:
                                    $row['Importe'] = trim($td->text());
                                    break;
                                case 4:
                                    $row['Situacion'] = trim($td->text());
                                    break;
                            }
                        });
                        

                        // Añade la fila al array de inscripciones
                        $data['inscripciones'][] = $row;
                    });
                }
            });
            
            $crawler->filter('.panel-primary')->each(function ($panel) use (&$data) {
                // Verifica si el título de la sección es "RESULTADOS DE EVALUACIONES PARCIALES"
                if ($panel->filter('.panel-title')->text() === 'RESULTADOS DE EVALUACIONES PARCIALES') {
                    $data['resultados parciales'] = [];
                    
                    // Itera sobre cada fila de la tabla
                    $panel->filter('.table-responsive table tr')->each(function ($tr, $i) use (&$data) {
                        // Ignora la primera fila que contiene los encabezados de la tabla
                        if ($i == 0) return;

                        $row = [];
                        $tr->filter('td')->each(function ($td, $j) use (&$row) {
                            // se obtiene el texto de cada columna y se mete a $row
                            switch ($j) {
                                case 0:
                                    $row['Materia'] = trim($td->text());
                                    break;
                                
                                case 1:
                                    $row['1ra parcial'] = trim($td->text());
                                    break;
                                case 2:
                                    $row['2da parcial'] = trim($td->text());
                                    break;
                                case 3:
                                    $row['Trab.Practico'] = trim($td->text());
                                    break;
                                case 4:
                                    $row['Trab.Laboratorio'] = trim($td->text());
                                        break;
                                case 5:
                                     $row['Evaluacion'] = trim($td->text());
                                            break;

                            }
                        });

                        // Añade la fila al array de inscripciones
                        $data['resultados parciales'][] = $row;
                    });
                }
            });
            $crawler->filter('.panel-primary')->each(function ($panel) use (&$data) {
                // Verifica si el título de la sección es "HABILITACIONES ACTUALES"
                if ($panel->filter('.panel-title')->text() === 'HABILITACIONES ACTUALES') {
                    $data['habilitaciones'] = [];
                    
                    // Itera sobre cada fila de la tabla
                    $panel->filter('.table-responsive table tr')->each(function ($tr, $i) use (&$data) {
                        // Ignora la primera fila que contiene los encabezados de la tabla
                        if ($i == 0) return;

                        $row = [];
                        $tr->filter('td')->each(function ($td, $j) use (&$row) {
                            // Obtén el texto de cada columna y almacénalo en $row
                            switch ($j) {
                                case 0:
                                    $row['Materia'] = trim($td->text());
                                    break;
                                case 1:
                                    $row['Bonificacion'] = trim($td->text());
                                    break;
                                case 2:
                                    $row['Vencimiento'] = trim($td->text());
                                    break;
                                case 3:
                                    $row['Periodo'] = trim($td->text());
                                    break;
                                    
                            }
                        });
                        

                        // Añade la fila al array de inscripciones
                        $data['habilitaciones'][] = $row;
                    });
                }
            });
            $crawler->filter('.panel-primary')->each(function ($panel) use (&$data) {
                // Verifica si el título de la sección es "CALIFICACIONES"
                if ($panel->filter('.panel-title')->text() === 'RESULTADOS DE EVALUACIONES FINALES') {
                    $data['evaluaciones finales'] = [];
                    
                    // Itera sobre cada fila de la tabla
                    $panel->filter('.table-responsive table tr')->each(function ($tr, $i) use (&$data) {
                        // Ignora la primera fila que contiene los encabezados de la tabla
                        if ($i == 0) return;

                        $row = [];
                        $tr->filter('td')->each(function ($td, $j) use (&$row) {
                            // Obtén el texto de cada columna y almacénalo en $row
                            switch ($j) {
                                case 0:
                                    $row['Materia'] = trim($td->text());
                                    break;
                                case 1:
                                    $row['Fecha'] = trim($td->text());
                                    break;
                                case 2:
                                    $row['Final(100%)'] = trim($td->text());
                                    break;
                                case 3:
                                    $row['Bonificacion'] = trim($td->text());
                                    break;
                                case 4  :
                                    $row['Total'] = trim($td->text());
                                    break;
                                case 5  :
                                    $row['Nota'] = trim($td->text());
                                    break;
                                      
                                    
                            }
                        });
                        

                        // Añade la fila al array de inscripciones
                        $data['evaluaciones finales'][] = $row;
                    });
                }
            });
            $crawler->filter('.panel-primary')->each(function ($panel) use (&$data) {
                // Verifica si el título de la sección es "CALIFICACIONES"
                if ($panel->filter('.panel-title')->text() === 'CALIFICACIONES') {
                    $data['calificaciones'] = [];
                    
                    // Itera sobre cada fila de la tabla
                    $panel->filter('.table-responsive table tr')->each(function ($tr, $i) use (&$data) {
                        // Ignora la primera fila que contiene los encabezados de la tabla
                        if ($i == 0) return;

                        $row = [];
                        $tr->filter('td')->each(function ($td, $j) use (&$row) {
                            // Obtén el texto de cada columna y almacénalo en $row
                            switch ($j) {
                                case 0:
                                    $row['Materia'] = trim($td->text());
                                    break;
                                case 1:
                                    $row['Semestre'] = trim($td->text());
                                    break;
                                case 2:
                                    $row['Fecha'] = trim($td->text());
                                    break;
                                case 3:
                                    $row['Nota'] = trim($td->text());
                                    break;
                                case 4  :
                                    $row['Acta'] = trim($td->text());
                                    break;
                                      
                                    
                            }
                        });
                        

                        // Añade la fila al array de inscripciones
                        $data['calificaciones'][] = $row;
                    });
                }
            });

            $crawler->filter('.panel-primary')->each(function ($panel) use (&$data) {
                // Verifica si el título de la sección es "CALIFICACIONES"
                if ($panel->filter('.panel-title')->text() === 'EXTENSIÓN') {
                    $data['extensiones'] = [];
                    
                    // Itera sobre cada fila de la tabla
                    $panel->filter('.table-responsive table tr')->each(function ($tr, $i) use (&$data) {
                        // Ignora la primera fila que contiene los encabezados de la tabla
                        if ($i == 0) return;

                        $row = [];
                        $tr->filter('td')->each(function ($td, $j) use (&$row) {
                            // Obtén el texto de cada columna y almacénalo en $row
                            switch ($j) {
                                case 0:
                                    $row['Carrera'] = trim($td->text());
                                    break;
                                case 1:
                                    $row['Actividad'] = trim($td->text());
                                    break;
                                case 2:
                                    $row['Tipo Actividad'] = trim($td->text());
                                    break;
                                case 3:
                                    $row['Maxima'] = trim($td->text());
                                    break;
                                case 4  :
                                    $row['Cantidad '] = trim($td->text());
                                    break;
                                case 5 :
                                    $row['Horas'] = trim($td->text());
                                    break;
                                
                                    
                            }
                            
                        });
                        

                        // Añade la fila al array de inscripciones
                        $data['extensiones'][] = $row;
                    });
                }
            });
            Log::info("Extracted Data: " . json_encode($data));
            return $data; // devuelve un obj json (lista de objetos, no mapa)
        } else {
            throw new \Exception("Error en la solicitud de inicio de sesión: " . $response->getStatusCode());
        }
    }
}
