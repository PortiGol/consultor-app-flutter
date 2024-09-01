<?php

namespace App\Http\Controllers;

use App\Services\ConsultorService;
use Illuminate\Http\Request;

class ConsultorController extends Controller
{
    protected $consultorService;

    public function __construct(ConsultorService $consultorService)
    {
        $this->consultorService = $consultorService; //constructor para acceder a la funcion getConsultorData desde aca..
    }

    public function getConsultorData(Request $request)
    {
        try {
            $username = $request->input('usuario');
            $password = $request->input('clave');
            $data = $this->consultorService->getConsultorData($username, $password);
            
            return response()->json(['message' => 'Success', 'data' => $data]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
